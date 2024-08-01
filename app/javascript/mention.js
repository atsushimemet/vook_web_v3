import Tribute from 'tributejs';

document.addEventListener('turbo:load', () => {
  const trixEditors = document.querySelectorAll('trix-editor');

  trixEditors.forEach((textarea) => {
    if (textarea) {
      fetch('/api/terms')
        .then((response) => response.json())
        .then((data) => {
          const tribute = new Tribute({
            collection: [
              {
                trigger: '@',
                values: data,
                lookup: 'name',
                menuItemLimit: 10,
                replaceTextSuffix: '',
                selectTemplate: (item) => {
                  return `<a href="/terms#${item.original.name}">${item.original.name}</a>`;
                },
              },
            ],
          });
          tribute.attach(textarea);
          return tribute;
        });
    }
  });
});
