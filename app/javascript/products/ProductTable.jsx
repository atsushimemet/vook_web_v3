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
import useSWR from 'swr';

const columns = [
  { id: 'name', label: '商品名', minWidth: 224 },
  { id: 'platform', label: '', minWidth: 96 },
  { id: 'price', label: '金額', minWidth: 88, sortable: true },
];

const fetcher = (url) => fetch(url).then((res) => res.json());

export default function StickyHeadTable() {
  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(30);
  const [order, setOrder] = React.useState('asc');
  const [orderBy, setOrderBy] = React.useState('price');
  const url = new URL(window.location.href);
  const productId = url.pathname.split('/').pop();

  const { data: rows = [], error } = useSWR(`/api/products/${productId}`, fetcher, {
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
  if (!rows) return <div>Loading...</div>;

  const MemoizedTableRow = React.memo(({ row, onClick }) => (
    <TableRow hover tabIndex={-1} key={row.id} onClick={onClick} className="tableRow">
      <TableCell align="left" className='tableRowName'>{row.name}</TableCell>
      <TableCell align="center">
        {row.platform.image_url && (
          <img
            src={row.platform.image_url}
            alt="プラットフォームの画像"
            loading="lazy"
            className='platformImage'
          />
        )}
      </TableCell>
      <TableCell align="center" className="tableRowPrice">
        {row.price}
      </TableCell>
    </TableRow>
  ));

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
            {sortedRows
              .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
              .map((row) => (
                <MemoizedTableRow
                  key={row.id}
                  row={row}
                  onClick={() => window.open(row.url, '_blank')}
                />
              ))}
          </TableBody>
        </Table>
      </TableContainer>
      <TablePagination
        rowsPerPageOptions={[30, 100]}
        component="div"
        count={rows.length}
        rowsPerPage={rowsPerPage}
        page={page}
        onPageChange={handleChangePage}
        onRowsPerPageChange={handleChangeRowsPerPage}
      />
    </Paper>
  );
}
