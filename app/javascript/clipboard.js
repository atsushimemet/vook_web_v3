import ClipboardJS from 'clipboard';

document.addEventListener('turbo:load', () => {
  const element = document.getElementById('copy-link');
  if (element) {
    const copyLink = new ClipboardJS('#copy-link');
    copyLink.on('success', () => {
      element.setAttribute('data-tooltip', 'Copied!');

      setTimeout(() => {
        element.removeAttribute('data-tooltip');
      }, 1000);
    });
  }
});
