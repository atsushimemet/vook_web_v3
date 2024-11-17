import React, { useEffect, useRef } from 'react';
import useSWR from 'swr';
import mermaid from 'mermaid';
import Skeleton from '@mui/material/Skeleton';

mermaid.initialize({
  startOnLoad: false,
  theme: 'base',
  themeVariables: {
    background: '#f9fafb',
    primaryColor: '#FCD900',
    primaryTextColor: '#00081a',
    primaryBorderColor: '#00081a',
    lineColor: '#00081a',
    secondaryColor: '#e6eaee',
  },
  securityLevel: 'loose',
});

const fetcher = (url) => fetch(url).then((res) => res.json());

export default function KnowledgeMermaid() {
  const url = new URL(window.location.href);
  const knowledgeId = url.pathname.split('/').pop();
  const { data, error, isLoading } = useSWR(
    `/api/knowledges/${knowledgeId}`,
    fetcher,
  );
  const mermaidPreviewRef = useRef(null);

  useEffect(() => {
    if (data?.knowledge?.mermaid_chart && mermaidPreviewRef.current) {
      const { mermaid_chart: mermaidChart } = data.knowledge;
      mermaidPreviewRef.current.removeAttribute('data-processed');
      mermaidPreviewRef.current.innerHTML = mermaidChart;

      mermaid.run();
    }
  }, [data]);

  if (error) return <div>Error loading Mermaid chart.</div>;

  return (
    <div className="mermaidContainer">
      <div className="mermaidBox">
        {isLoading ? (
          <Skeleton variant="rectangular" className="skelton" />
        ) : (
          <div ref={mermaidPreviewRef} className="mermaid" />
        )}
      </div>
    </div>
  );
}
