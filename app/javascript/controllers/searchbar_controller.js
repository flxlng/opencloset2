import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {
  connect() {
    console.log("Hello from toggle_controller.js")
  }
  autoSubmit(event) {
    console.log("Hello from autoSubmit2")
    const form = this.element.querySelector('form');
    if (form) {
      form.submit();
  } else {
      console.error("Form element not found");
  }
  }
}

// document.addEventListener("turbo:load", () => {
//     const searchField = document.getElementById('piecesearch');
//     const form = document.getElementById('search-form');

//     if (searchField && form) {
//       searchField.addEventListener('keyup', (event) => {
//         form.submit(); // Submits the form
//       });
//     }
//   });
