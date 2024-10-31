document.addEventListener('turbo:load', () => {
  const pageLoader = document.getElementById('pageloader');
  if (pageLoader) {
    pageLoader.classList.add('loaded');
  }
});
