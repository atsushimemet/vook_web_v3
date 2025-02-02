import Splide from '@splidejs/splide';

let splideInstance;

const splideOptions = {
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
      perMove: 5,
      rewind: false,
      padding: 0,
      focus: 1,
      gap: '0.5rem',
      omitEnd: true,
      arrows: false,
    },
  },
};

document.addEventListener('turbo:load', () => {
  const splide = document.getElementById('product-splide');

  if (splideInstance) {
    splideInstance.destroy();
  }

  if (splide) {
    splideInstance = new Splide(splide, splideOptions).mount();
  }
});
