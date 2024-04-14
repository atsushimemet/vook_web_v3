import Choices from 'choices.js'

document.addEventListener('turbo:load', () => {
  const element = document.getElementById('magazine-tag');

  if (element) {
    return new Choices(element, {
      allowHTML: true,
      delimiter: ',',
      removeItemButton: true,
      maxItemCount: 5,
      addItemText: (value) => {
        return `Enterを押すと<b>「${value}」</b>のタグが追加されます`
      },
      maxItemText: (maxItemCount) => {
        return `タグは最大${maxItemCount}つまでです。`
      }
    })
  }
})
