document.addEventListener('turbo:load', () => {
  const sizeButtons = document.querySelectorAll('.size-button')

  if (sizeButtons) {
    sizeButtons.forEach(button => {
      button.addEventListener('click', event => {
        const selectedSize = event.currentTarget.getAttribute('data-size-id');
        const knowledgeId = event.currentTarget.getAttribute('data-knowledge-id');
        fetchProductsBySize(selectedSize, knowledgeId);
      });
    });
  };
});

const fetchProductsBySize = async (size, knowledgeId) => {
  try {
    const endpoint = `/product/${knowledgeId}${size ? `?size=${size}` : ''}`;
    const response = await fetch(endpoint, {
      headers: {
        "Accept": "text/javascript",
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')
      }
    });
    const data = await response.text();
    const productList = document.getElementById('product-list');
    productList.innerHTML = data;
  } catch (error) {
    console.error("There was an error fetching the products:", error);
  }
}
