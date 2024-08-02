import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {
static targets = [ "form", "input", "results" ]

  connect() {
    console.log("Hello from the searchbar_controller.js")
  }

  search() {
    console.log("searching...")
    const query = this.inputTarget.value
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.performSearch(query)
    }, 300)
  }

  performSearch(query) {
    console.log("performing search for", query);
    fetch(`/search?query=${encodeURIComponent(query)}`, {
      headers: { "Accept": "application/json" }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const contentType = response.headers.get("content-type");
      if (contentType && contentType.includes("application/json")) {
        return response.json();
      } else {
        throw new Error("Oops, we haven't got JSON!");
      }
    })
    .then(data => {
      this.resultsTarget.innerHTML = this.renderResults(data.pieces);
    })
    .catch(error => {
      console.error("Error:", error);
      this.resultsTarget.innerHTML = `<p>An error occurred: ${error.message}</p>`;
    });
  }

  renderResults(pieces) {
    console.log(pieces);
    return pieces.map(piece => `
      <div class="piece-result">
        <h3>${piece.name}</h3>
        <p>${piece.description}</p>
        <p>${piece.photos && piece.photos[0] && piece.photos[0].key ? `<%= cl_image_tag('${piece.photos[0].key}', { height: 300, width: 400, crop: 'fill' }) %>` : ''}</p>
      </div>
    `).join('');
  }



  // send(event) {
  //   event.preventDefault()
  //   this.searchPieces(event)
  // }

  // searchPieces(event) {
  //   event.preventDefault();
  //   const term = this.formTarget.querySelector("#search-form").value;

  //   fetch(`/search?query=${term}`, {
  //     method: 'GET',
  //     headers: {
  //       'Content-Type': 'application/json'
  //     }
  //   })
  //   .then(response => response.json())
  //   .then(data => this.appendPiecesToDom(data.pieces))
  //   .catch(error => console.error("Error:", error.message));
  // }

  // appendPiecesToDom(pieces) {
  //   console.log(pieces)
  //   const piecesContainer = this.itemTarget;
  //   piecesContainer.innerHTML = ""; // Clear the previous results if any
  //   pieces.forEach((piece) => {
  //     const cardHTML = this.createPieceCard(piece);
  //     piecesContainer.insertAdjacentHTML('beforeend', cardHTML);
  //   });
  // }

  // createPieceCard(piece) {
  //   return `
  //     <div>
  //     ${piece.name}
  //     </div>
  //   `
  // }
}
