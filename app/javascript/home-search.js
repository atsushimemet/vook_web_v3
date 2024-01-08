import Choices from 'choices.js';

document.addEventListener('turbo:load', () => {
  const knowledgeSearch = document.querySelector('.knowledge-search');

  if (knowledgeSearch) {
    const knowledgeChoices = new Choices(knowledgeSearch, {
      allowHTML: true,
      searchResultLimit: 10,
      noResultsText: '一致する情報は見つかりません',
      itemSelectText: '',
      placeholderValue: '知りたいブランドやアイテムを入力',
    });

    knowledgeChoices.setChoices(async () => {
      const response = await fetch(`api/knowledges`);
      const knowledges = await response.json();
      return knowledges.map((knowledge) => {
        return {
          label: knowledge.name_with_brand_and_line,
          value: knowledge.id,
        };
      });
    });

    knowledgeSearch.addEventListener('change', (event) => {
      const selectedValue = event.detail.value;
      if (selectedValue) {
        window.location.href = `/knowledges/${selectedValue}`;
      }
    });
  }

  const productSearch = document.querySelector('.product-search');

  if (productSearch) {
    const knowledgeChoices = new Choices(productSearch, {
      allowHTML: true,
      searchResultLimit: 10,
      noResultsText: '一致する情報は見つかりません',
      itemSelectText: '',
      placeholderValue: '欲しいブランドやアイテムを入力',
    });

    knowledgeChoices.setChoices(async () => {
      const response = await fetch(`api/knowledges`);
      const knowledges = await response.json();
      return knowledges.map((knowledge) => {
        return {
          label: knowledge.name_with_brand_and_line,
          value: knowledge.id,
        };
      });
    });

    productSearch.addEventListener('change', (event) => {
      const selectedValue = event.detail.value;
      if (selectedValue) {
        window.location.href = `/products/${selectedValue}`;
      }
    });
  }
});
