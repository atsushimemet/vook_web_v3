const lineSelect = () => {
  const brandSelect = document.querySelector('#knowledge_brand_id');
  const lineSelect = document.querySelector('#knowledge_line_id');

  if (brandSelect) {
    const createOption = (line) => {
      const option = document.createElement('option');
      option.value = line.id;
      option.text = line.name;
      return option;
    };

    const fetchLineOptions = async () => {
      const childrenPath =
        brandSelect.options[brandSelect.selectedIndex].dataset.childrenPath;

      try {
        const response = await fetch(childrenPath);
        if (!response.ok) throw new Error('Network response was not ok');

        const lines = await response.json();

        lineSelect.innerHTML = '';
        lines.forEach((line) => {
          const option = createOption(line);
          lineSelect.appendChild(option);
        });
      } catch (error) {
        console.error('Error occurred while initializing line options');
        console.log('Error:', error.message);
      }
    };

    brandSelect.addEventListener('change', fetchLineOptions);
  }
};

document.addEventListener('turbo:load', lineSelect);
document.addEventListener('turbo:render', lineSelect);
