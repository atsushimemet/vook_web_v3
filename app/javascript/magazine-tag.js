import Choices from 'choices.js';

document.addEventListener('turbo:load', () => {
  const tagForm = document.getElementById('magazine-tag');

  if (tagForm) {
    return new Choices(tagForm, {
      allowHTML: true,
      delimiter: ',',
      removeItemButton: true,
      maxItemCount: 5,
      addItemText: (value) => {
        return `Enterを押すと<b>「${value}」</b>のタグが追加されます`;
      },
      maxItemText: (maxItemCount) => {
        return `タグは最大${maxItemCount}つまでです。`;
      },
    });
  }
});
