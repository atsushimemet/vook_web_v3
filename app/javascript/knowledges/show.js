import '../knowledge-mermaid';
import '../clipboard';
import * as React from 'react';
import * as ReactDOM from 'react-dom/client';
import { StyledEngineProvider } from '@mui/material/styles';
import PriceHistogram from './PriceHistogram';

ReactDOM.createRoot(document.getElementById('price-histogram')).render(
  <React.StrictMode>
    <StyledEngineProvider injectFirst>
      <PriceHistogram />
    </StyledEngineProvider>
  </React.StrictMode>,
);
