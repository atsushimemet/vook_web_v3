import '../clipboard';
import * as React from 'react';
import * as ReactDOM from 'react-dom/client';
import { StyledEngineProvider } from '@mui/material/styles';
import PriceHistogram from './PriceHistogram';
import KnowledgeMermaid from './KnowledgeMermaid';

const priceHistogramElement = document.getElementById('price-histogram');
if (priceHistogramElement) {
  ReactDOM.createRoot(priceHistogramElement).render(
    <React.StrictMode>
      <StyledEngineProvider injectFirst>
        <PriceHistogram />
      </StyledEngineProvider>
    </React.StrictMode>,
  );
}

const knowledgeMermaidElement = document.getElementById('knowledge-mermaid');
if (knowledgeMermaidElement) {
  ReactDOM.createRoot(knowledgeMermaidElement).render(
    <React.StrictMode>
      <StyledEngineProvider injectFirst>
        <KnowledgeMermaid />
      </StyledEngineProvider>
    </React.StrictMode>,
  );
}
