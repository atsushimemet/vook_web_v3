document.addEventListener('turbo:load', () => {
  const navbarBurger = document.querySelector('.navbar-burger');

  navbarBurger.addEventListener('click', () => {
    const target = navbarBurger.dataset.target;
    const navbarMenu = document.getElementById(target);

    navbarMenu.classList.toggle('is-active');
    navbarBurger.classList.toggle('is-active');
  });
});
