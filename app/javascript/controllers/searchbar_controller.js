import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {
static targets = [ "form", "item" ]

  connect() {
    console.log("Hello from toggle_controller.js")
  }
  autoSubmit(event) {
    console.log("Hello from autoSubmit")
  //   const form = this.element.querySelector('form');
  //   if (form) {
  //     form.submit();
  // } else {
  //     console.error("Form element not found");
  // }
  }

  send(event) {
    event.preventDefault()

    console.log("TODO: send request in AJAX")

    fetch(this.formTarget.action, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => {
      if (!response.ok) {
        return response.json().then(errorData => {
          throw new Error(errorData.errors.join(", "));
        });
      }
      return response.json();
    })
    .then((data) => {
      console.log(data.inserted_item);
    })
    .catch((error) => {
      console.error("Error:", error.message);
    });
  }
}
