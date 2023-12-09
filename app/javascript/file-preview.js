document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.file-input').forEach((input) => {
    input.addEventListener('change', () => {
      const fileNameDisplay = input
        .closest('.file')
        .querySelector('.file-name');
      const fileName =
        input.files.length > 0 ? input.files[0].name : 'No file uploaded';
      fileNameDisplay.textContent = fileName;
    });
  });
});
