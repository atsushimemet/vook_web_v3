document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.trix-content a').forEach((link) => {
    if (link.hostname !== window.location.hostname) {
      link.setAttribute('target', '_blank');
    }
  });
});
