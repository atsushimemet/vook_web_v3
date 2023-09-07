import Splide from '@splidejs/splide';

document.addEventListener('turbo:load', () => {
  const splide = document.querySelector('.splide');
  if (splide) {
    new Splide('.splide', {
      type: 'loop',
      perPage: 3,
      perMove: 1,
      rewind: true,
      gap: '2rem',
      padding: '6rem',
      focus: 'center',
      lazyLoad: 'nearby',
      breakpoints: {
        768: {
          type: 'slide',
          perPage: 2,
          perMove: 1,
          rewind: false,
          padding: 0,
          focus: 1,
          gap: '0.5rem',
          omitEnd: true,
          arrows: false,
        },
      },
    }).mount();
  }
});
