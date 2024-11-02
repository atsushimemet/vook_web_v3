import '../clipboard';
import '../size-select';
import * as React from 'react';
import * as ReactDOM from 'react-dom/client';
import { StyledEngineProvider } from '@mui/material/styles';
import ProductTable from './ProductTable';

ReactDOM.createRoot(document.getElementById('product-table')).render(
  <React.StrictMode>
    <StyledEngineProvider injectFirst>
      <ProductTable />
    </StyledEngineProvider>
  </React.StrictMode>
);
