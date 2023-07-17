document.addEventListener('turbo:load', () => {
  const pageLoader = document.querySelector('.pageloader');
  if (pageLoader) {
    pageLoader.classList.add('loaded');
  }
});
