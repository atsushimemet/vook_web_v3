import '../clipboard';
import * as React from 'react';
import * as ReactDOM from 'react-dom/client';
import { StyledEngineProvider } from '@mui/material/styles';
import PriceHistogram from './PriceHistogram';
import KnowledgeMermaid from './KnowledgeMermaid';

ReactDOM.createRoot(document.getElementById('price-histogram')).render(
  <React.StrictMode>
    <StyledEngineProvider injectFirst>
      <PriceHistogram />
    </StyledEngineProvider>
  </React.StrictMode>,
);

const example = `graph TD
    A[シルエットは？] -->|ストレート以外| B[501ではない]
    A -->|ストレート| C[フロントは？]
    C -->|ジッパーフライ| D[501ではない]
    C -->|ボタンフライ| E[ボタン裏の刻印は?]
    E -->|特定の数字・記号・アルファベットでない| F[赤耳以降]
    E -->|特定の数字・記号・アルファベット（2/4/6/8/12/14/15/16/20/E/J/K/L/S/W/::）| G[バックポケット裏ステッチは?]
    G -->|チェーン| H[66後期]
    G -->|シングル| I[赤タブは?]
    I -->|small e| J[66前期]
    I -->|読み取り不可| K[セルビッジ裏ステッチは?]
    I -->|BIG E| L[フロントステッチは?]
    K --> |片方シングル| M[66前期]
    K --> |両方シングル| L
    L --> |並行ステッチ| N[BIG E 後期]
    L --> |Vステッチ| O[隠しリベット/股カンヌキは?]
    O --> |隠しリベットあり| P[501XX]
    O --> |隠しリベットなし &amp; 股カンヌキあり| Q[BIG E 初期]
    O --> |隠しリベットなし &amp; 股カンヌキなし| R[最終501XX]`;

function App() {
  return (
    <div className="App">
      <KnowledgeMermaid chart={example} />
    </div>
  );
}

const rootElement = document.getElementById('knowledge-mermaid');
ReactDOM.createRoot(rootElement).render(<App />);

// ReactDOM.createRoot(document.getElementById('knowledge-mermaid')).render(
//   <React.StrictMode>
//     <StyledEngineProvider injectFirst>
//       <KnowledgeMermaid />
//     </StyledEngineProvider>
//   </React.StrictMode>,
// );
