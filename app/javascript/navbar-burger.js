document.addEventListener('DOMContentLoaded', () => {
  const navbarBurger = document.querySelectorAll('.navbar-burger');

  navbarBurger.forEach(burger => {
    burger.addEventListener('click', () => {
      const target = burger.dataset.target;
      const navbarMenu = document.getElementById(target);

      navbarMenu.classList.toggle('is-active');
    });
  })
});
