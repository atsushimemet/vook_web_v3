document.addEventListener('turbo:load', () => {
  const tabLists = document.querySelectorAll('.tab-list');
  const tabContent = document.querySelectorAll('.tab-content');

  if (tabLists) {
    tabLists.forEach((tab, index) => {
      tab.addEventListener('click', () => {
        tabLists.forEach((tab) => tab.classList.remove('is-active'));
        tab.classList.add('is-active');

        tabContent.forEach((content) => content.classList.remove('is-active'));
        tabContent[index].classList.add('is-active');
      });
    });
  }
});
