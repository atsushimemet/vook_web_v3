document.addEventListener('turbo:load', () => {
  const publishAtField = document.getElementById('magazine_publish_at');
  const clearButton = document.getElementById('clear-publish_at');

  if (clearButton) {
    clearButton.addEventListener('click', () => {
      publishAtField.value = '';
    });
  }
});
