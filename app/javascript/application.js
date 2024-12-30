// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("turbo:load", function() {
  // Initialize all dropdowns
  const dropdownElementList = document.querySelectorAll('.dropdown-toggle')
  const dropdownList = [...dropdownElementList].map(dropdownToggleEl => {
    return new bootstrap.Dropdown(dropdownToggleEl)
  })

  // Initialize navbar toggler for mobile
  const navbarToggler = document.querySelector('.navbar-toggler')
  if (navbarToggler) {
    navbarToggler.addEventListener('click', function() {
      const targetId = this.getAttribute('data-bs-target')
      const targetElement = document.querySelector(targetId)
      if (targetElement) {
        new bootstrap.Collapse(targetElement)
      }
    })
  }
})

