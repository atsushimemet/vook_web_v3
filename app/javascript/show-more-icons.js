import bulmaCollapsible from '@creativebulma/bulma-collapsible';

document.addEventListener('turbo:load', () => {
  const collapsibles = bulmaCollapsible.attach('.is-collapsible');

  const handleTriggerClick = (trigger) => {
    const target = document.querySelector(trigger.getAttribute('href'));
    const collapsible = collapsibles.find(
      (collapsible) => collapsible.element === target
    );
    collapsible.open();
    trigger.style.display = 'none';
  };

  const moreBrandsTrigger = document.querySelector('.more-brands-trigger');
  const moreItemsTrigger = document.querySelector('.more-items-trigger');

  moreBrandsTrigger?.addEventListener('click', (event) => {
    event.preventDefault();
    handleTriggerClick(moreBrandsTrigger);
  });

  moreItemsTrigger?.addEventListener('click', (event) => {
    event.preventDefault();
    handleTriggerClick(moreItemsTrigger);
  });
});
