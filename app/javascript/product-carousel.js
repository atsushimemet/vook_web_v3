import Splide from '@splidejs/splide';

let splideInstance;

const splideOptions = {
  type: 'loop',
  perPage: 3,
  perMove: 1,
  rewind: true,
  autoplay: true,
  padding: '6em',
  focus: 'center',
  lazyLoad: 'nearby',
  breakpoints: {
    768: {
      type: 'slide',
      perPage: 2,
      perMove: 5,
      autoplay: false,
      rewind: false,
      padding: '1em',
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
