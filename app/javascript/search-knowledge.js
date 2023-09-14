import Choices from 'choices.js';

document.addEventListener('turbo:load', () => {
  const knowledgeSearch = document.querySelector('.knowledge-search');
  if (knowledgeSearch) {
    knowledgeSearch.selectedIndex = 0;
    // eslint-disable-next-line no-new
    new Choices(knowledgeSearch, {
      allowHTML: true,
      searchResultLimit: 10,
      noResultsText: '一致する情報は見つかりません',
      itemSelectText: '',
    });

    knowledgeSearch.addEventListener('change', function () {
      const selectedValue = this.value;
      if (selectedValue) {
        window.location.href = `/knowledges/${selectedValue}`;
      }
    });
  }
});
