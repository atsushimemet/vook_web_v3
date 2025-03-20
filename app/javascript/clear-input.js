document.addEventListener('turbo:load', () => {
  const publishAtField = document.getElementById('publish_at-field');
  const clearButton = document.getElementById('clear-publish_at');

  if (clearButton) {
    clearButton.addEventListener('click', () => {
      publishAtField.value = '';
    });
  }
});
