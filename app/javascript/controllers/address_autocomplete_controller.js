import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static targets = ["autocomplete", "streetNumber", "route", "locality", "administrativeArea", "country", "postalCode"];

  connect() {
    this.autocompleteTarget.addEventListener('keyup', this.handleKeyUp.bind(this));
  }

  handleKeyUp(event) {
    if (event.key.length === 1 || event.key === 'Backspace') {
      this.fetchSuggestions(this.autocompleteTarget.value);
    }
  }

  fetchSuggestions(query) {
    console.log("query", query);
    if (query.length < 3) return;

    fetch(`/addresses/autocomplete?query=${query}`)
      .then(response => response.json())
      .then(data => {
        console.log("data", data);
        this.displaySuggestions(data.predictions);
      })
      .catch(error => {
        console.error('Error fetching autocomplete suggestions:', error);
      });
  }
}
