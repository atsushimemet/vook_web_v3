import ClipboardJS from 'clipboard';

const copyLink = new ClipboardJS('#copy-link');
const element = document.getElementById('copy-link');
copyLink.on('success', () => {
  element.setAttribute('data-tooltip', 'Copied!');

  setTimeout(() => {
    element.removeAttribute('data-tooltip');
  }, 1000);
});
