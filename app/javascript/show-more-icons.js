document.addEventListener('turbo:load', () => {
  const triggers = document.querySelectorAll('.accordion-trigger');

  triggers.forEach((trigger) => {
    trigger.addEventListener('click', (event) => {
      event.preventDefault();

      const targetId = trigger.dataset.target;
      const targetContent = document.querySelector(targetId);

      trigger.style.display = 'none';
      targetContent.classList.add('is-open');
      targetContent.style.maxHeight = targetContent.scrollHeight + 'px';
    });
  });
});
