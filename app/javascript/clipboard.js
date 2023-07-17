import ClipboardJS from 'clipboard';

document.addEventListener('turbo:load', () => {
  const element = document.querySelector('.copy-link');
  if (element) {
    const copyLink = new ClipboardJS('.copy-link');
    copyLink.on('success', () => {
      element.setAttribute('data-tooltip', 'コピーしました');

      setTimeout(() => {
        element.removeAttribute('data-tooltip');
      }, 1000);
    });
  }
});
