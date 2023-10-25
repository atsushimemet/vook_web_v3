import bulmaCollapsible from '@creativebulma/bulma-collapsible';

document.addEventListener('turbo:load', () => {
  const collapsible = bulmaCollapsible.attach('.is-collapsible')[0];
  const moreBrandsTrigger = document.querySelector('.more-brands-trigger');

  moreBrandsTrigger?.addEventListener('click', (event) => {
    event.preventDefault();
    collapsible.open();
    moreBrandsTrigger.style.display = 'none';
  });
});
