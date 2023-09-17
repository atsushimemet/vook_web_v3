import Choices from 'choices.js';

let choicesInstance;

document.addEventListener('turbo:load', () => {
  const knowledgeSearch = document.querySelector('.knowledge-search');

  if (choicesInstance) {
    choicesInstance.destroy();
  }

  if (knowledgeSearch) {
    knowledgeSearch.selectedIndex = 0;
    choicesInstance = new Choices(knowledgeSearch, {
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
