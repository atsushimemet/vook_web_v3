import * as React from 'react';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';
import TableSortLabel from '@mui/material/TableSortLabel';
import Skeleton from '@mui/material/Skeleton';
import useSWR from 'swr';

const columns = [
  { id: 'name', label: '商品名', minWidth: 224 },
  { id: 'price', label: '金額', minWidth: 88, sortable: true },
  { id: 'platform', label: '', minWidth: 96 },
];

const fetcher = (url) => fetch(url).then((res) => res.json());

export default function StickyHeadTable() {
  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(30);
  const [order, setOrder] = React.useState('asc');
  const [orderBy, setOrderBy] = React.useState('price');
  const url = new URL(window.location.href);
  const productId = url.pathname.split('/').pop();

  const {
    data: rows,
    error,
    isLoading,
  } = useSWR(`/api/products/${productId}`, fetcher, {
    revalidateOnFocus: false,
  });

  const handleRequestSort = (property) => {
    const isAsc = orderBy === property && order === 'asc';
    setOrder(isAsc ? 'desc' : 'asc');
    setOrderBy(property);
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(+event.target.value);
    setPage(0);
  };

  const sortedRows = React.useMemo(() => {
    if (!rows) return [];
    return [...rows].sort((a, b) => {
      if (a[orderBy] < b[orderBy]) {
        return order === 'asc' ? -1 : 1;
      }
      if (a[orderBy] > b[orderBy]) {
        return order === 'asc' ? 1 : -1;
      }
      return 0;
    });
  }, [rows, order, orderBy]);

  if (error) return <div>Error loading data</div>;

  return (
    <Paper sx={{ width: '100%', overflow: 'hidden' }}>
      <TableContainer sx={{ maxHeight: 800 }}>
        <Table stickyHeader aria-label="sticky table">
          <TableHead>
            <TableRow>
              {columns.map((column) => (
                <TableCell
                  key={column.id}
                  align="center"
                  className="tableHead"
                  style={{ minWidth: column.minWidth }}
                  sortDirection={orderBy === column.id ? order : false}
                >
                  {column.sortable ? (
                    <TableSortLabel
                      active={orderBy === column.id}
                      direction={orderBy === column.id ? order : 'asc'}
                      onClick={() => handleRequestSort(column.id)}
                    >
                      {column.label}
                    </TableSortLabel>
                  ) : (
                    column.label
                  )}
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
          <TableBody>
            {isLoading
              ? Array.from({ length: rowsPerPage }).map((_, index) => (
                  <TableRow key={index}>
                    {columns.map((column) => (
                      <TableCell key={column.id} align="center">
                        <Skeleton
                          variant="rectangular"
                          style={{ minWidth: column.minWidth }}
                          height={24}
                        />
                      </TableCell>
                    ))}
                  </TableRow>
                ))
              : sortedRows
                  .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                  .map((row) => (
                    <TableRow
                      hover
                      tabIndex={-1}
                      key={row.id}
                      className="tableRow"
                      onClick={() => window.open(row.url, '_blank')}
                    >
                      <TableCell align="left">{row.name}</TableCell>
                      <TableCell align="center" className="tableRowPrice">
                        {row.price}
                      </TableCell>
                      <TableCell align="center">
                        {row.platform.image_url && (
                          <img
                            src={row.platform.image_url}
                            alt="プラットフォームの画像"
                            loading="lazy"
                            className="platformImage"
                          />
                        )}
                      </TableCell>
                    </TableRow>
                  ))}
          </TableBody>
        </Table>
      </TableContainer>
      <TablePagination
        rowsPerPageOptions={[30, 100]}
        component="div"
        count={rows ? rows.length : 0}
        rowsPerPage={rowsPerPage}
        page={page}
        onPageChange={handleChangePage}
        onRowsPerPageChange={handleChangeRowsPerPage}
      />
    </Paper>
  );
}
