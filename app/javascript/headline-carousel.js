import Splide from '@splidejs/splide';

const mainSplideOptions = {
  type: 'fade',
  rewind: true,
  pagination: false,
  arrows: false,
};

const splideOptions = {
  type: 'slide',
  rewind: true,
  perPage: 4,
  pagination: false,
  isNavigation: true,
  autoplay: true,
  breakpoints: {
    768: {
      perPage: 2,
    },
  },
};

document.addEventListener('turbo:load', () => {
  const main = document.getElementById('headline-main-splide');
  const thumbnails = document.getElementById('headline-splide');

  if (main && thumbnails) {
    const mainSplide = new Splide(main, mainSplideOptions);
    const splide = new Splide(thumbnails, splideOptions);

    mainSplide.sync(splide);
    mainSplide.mount();
    splide.mount();
  }
});
