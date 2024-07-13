document.addEventListener('turbo:load', () => {
  const pageTop = document.querySelector('.pagetop');

  if (pageTop) {
    window.addEventListener('scroll', () => {
      if (window.scrollY > 300) {
        pageTop.style.opacity = 1;
      } else {
        pageTop.style.opacity = 0;
      }
    });

    pageTop.addEventListener('click', () => {
      window.scroll({ top: 0, behavior: 'smooth' });
    });
  }
});
