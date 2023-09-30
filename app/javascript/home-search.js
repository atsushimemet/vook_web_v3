import Choices from 'choices.js';

let choicesInstanceKnowledge;
let choicesInstanceProduct;

document.addEventListener('turbo:load', () => {
  const knowledgeSearch = document.querySelector('.knowledge-search');

  if (choicesInstanceKnowledge) {
    choicesInstanceKnowledge.destroy();
  }

  if (knowledgeSearch) {
    knowledgeSearch.selectedIndex = 0;
    choicesInstanceKnowledge = new Choices(knowledgeSearch, {
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

  const productSearch = document.querySelector('.product-search');

  if (choicesInstanceProduct) {
    choicesInstanceProduct.destroy();
  }

  if (productSearch) {
    productSearch.selectedIndex = 0;
    choicesInstanceProduct = new Choices(productSearch, {
      allowHTML: true,
      searchResultLimit: 10,
      noResultsText: '一致する商品は見つかりません',
      itemSelectText: '',
    });

    productSearch.addEventListener('change', function () {
      const selectedValue = this.value;
      if (selectedValue) {
        window.location.href = `/products/${selectedValue}`;
      }
    });
  }
});
