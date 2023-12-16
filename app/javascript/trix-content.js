document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.trix-content a').forEach((link) => {
    if (link.hostname !== window.location.hostname) {
      link.setAttribute('target', '_blank');
    } else if (link.getAttribute('href').startsWith('/terms#')) {
      link.setAttribute('data-turbo', 'false');
    }
  });
});
