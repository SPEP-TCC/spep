localStorage.setItem('layout', 'color-header');
document.querySelectorAll('.select2').forEach(element => {
  new Choices(element);
});