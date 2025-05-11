import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static targets = ["autocomplete", "results", "streetNumber", "route", "locality", "administrativeArea", "country", "postalCode"]

  connect() {
    this.boundHandleKeyUp = this.handleKeyUp.bind(this)
    this.autocompleteTarget.addEventListener("keyup", this.boundHandleKeyUp)
    this.debounceTimeout = null
  }

  disconnect() {
    this.autocompleteTarget.removeEventListener("keyup", this.boundHandleKeyUp)
    if (this.debounceTimeout) clearTimeout(this.debounceTimeout)
  }

  async handleKeyUp(event) {
    const query = event.target.value
    if (this.debounceTimeout) clearTimeout(this.debounceTimeout)

    if (query.length >= 3) {
      this.debounceTimeout = setTimeout(() => {
        this.fetchSuggestions(query)
      }, 300) // 300ms delay
    } else {
      this.debounceTimeout = setTimeout(() => {
        this.resultsTarget.innerHTML = ""
      }, 300) // 300ms delay
    }
  }

  async fetchSuggestions(query) {
    try {
      const response = await fetch(`/addresses/autocomplete?query=${encodeURIComponent(query)}`, {
        headers: {
          "Accept": "text/vnd.turbo-stream.html"
        }
      })
      
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      
      const html = await response.text()
      this.resultsTarget.innerHTML = html
    } catch (error) {
      console.error("Error fetching autocomplete suggestions:", error)
      this.resultsTarget.innerHTML = ""
    }
  }

  selectAddress(event) {
    const addressData = JSON.parse(event.currentTarget.dataset.addressValue)
    const address = addressData.address

    // Update the autocomplete input with the selected address
    this.autocompleteTarget.value = addressData.display_name

    // Update hidden fields with address components
    if (this.hasStreetNumberTarget) this.streetNumberTarget.value = address.house_number || ""
    if (this.hasRouteTarget) this.routeTarget.value = address.street || ""
    if (this.hasLocalityTarget) this.localityTarget.value = address.locality || ""
    if (this.hasAdministrativeAreaTarget) this.administrativeAreaTarget.value = address.administrative_area_level_1 || ""
    if (this.hasCountryTarget) this.countryTarget.value = address.country || ""
    if (this.hasPostalCodeTarget) this.postalCodeTarget.value = address.postcode || ""

    // Clear the results
    this.resultsTarget.innerHTML = ""
  }
}

