import mermaid from 'mermaid';

document.addEventListener('turbo:load', () => {
  const options = {
    theme: 'base',
    themeVariables: {
      primaryColor: '#FCD900',
      primaryTextColor: '#00081a',
      primaryBorderColor: '#00081a',
      lineColor: '#00081a',
      secondaryColor: '#e6eaee',
      tertiaryColor: '#f2f4f7',
    },
    securityLevel: 'loose',
  };
  mermaid.initialize(options);
  mermaid.run();

  const mermaidTextArea = document.querySelector('.mermaid-textarea');

  const updateMermaidPreview = () => {
    const code = mermaidTextArea.value;
    const mermaidPreview = document.getElementById('mermaid-preview');

    mermaidPreview.removeAttribute('data-processed');
    mermaidPreview.innerHTML = code;
    mermaid.run();
  };

  if (mermaidTextArea) {
    updateMermaidPreview();
    mermaidTextArea.addEventListener('input', updateMermaidPreview);
  }
});
