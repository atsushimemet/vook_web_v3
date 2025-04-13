import Splide from '@splidejs/splide';
import { AutoScroll } from '@splidejs/splide-extension-auto-scroll';

let splideInstance;

const splideOptions = {
  type: 'loop',
  perPage: 4,
  arrows: false,
  pagination: false,
  rewind: true,
  padding: '0.5em',
  lazyLoad: 'nearby',
  breakpoints: {
    768: {
      perPage: 2,
    },
  },
  autoScroll: {
    speed: 0.5,
  },
};

document.addEventListener('turbo:load', () => {
  const splide = document.getElementById('lookvook-splide');

  if (splideInstance) {
    splideInstance.destroy();
  }

  if (splide) {
    splideInstance = new Splide(splide, splideOptions).mount({ AutoScroll });
  }
});
