const lineSelect = () => {
  const brandSelect = document.querySelector('#knowledge_brand_id');
  const lineSelect = document.querySelector('#knowledge_line_id');
  const itemSelect = document.querySelector('#knowledge_item_id');

  const createOption = (line) => {
    const option = document.createElement('option');
    option.value = line.id;
    option.text = line.name;
    option.setAttribute('item_id', line.item_id);
    return option;
  };

  const setItemId = async () => {
    const selectedLine = lineSelect.options[lineSelect.selectedIndex];
    itemSelect.value = parseInt(selectedLine.getAttribute('item_id'));
  };

  const fetchLineOptions = async () => {
    const childrenPath = brandSelect.options[brandSelect.selectedIndex].dataset.childrenPath;

    try {
      const response = await fetch(childrenPath);
      if (!response.ok) throw new Error('Network response was not ok');

      const lines = await response.json();

      lineSelect.innerHTML = '';
      lines.forEach((line) => {
        const option = createOption(line);
        lineSelect.appendChild(option);
      });

      await setItemId();
    } catch (error) {
      console.error('Error occurred while initializing line options');
      console.log('Error:', error.message);
    }
  };

  brandSelect.addEventListener('change', fetchLineOptions);
  lineSelect.addEventListener('change', setItemId);
};

document.addEventListener('turbo:load', lineSelect);
document.addEventListener('turbo:render', lineSelect);
