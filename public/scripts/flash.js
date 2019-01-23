if (document.querySelector('.remove-btn')) {
  const removeBtn = document.querySelector('.remove-btn');

  const close = () => {
      const toDelete = document.querySelector('.flash'),
          wrapper = document.getElementById('wrapper');

      wrapper.removeChild(toDelete);
  };

  removeBtn.onclick = close;
}     