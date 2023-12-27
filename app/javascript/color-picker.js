document.addEventListener('turbo:load', () => {
  const colorPicker = document.querySelector('.color-picker');
  const colorLabel = document.querySelector('.color-label');

  if (colorPicker) {
    colorPicker.addEventListener('input', () => {
      colorLabel.textContent = colorPicker.value;
    });
  }
});
