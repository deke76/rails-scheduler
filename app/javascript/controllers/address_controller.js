import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "menu"]

  connect() {
    console.log("Address controller connected!")
  }

  handleNewAddress(event) {
    event.preventDefault()
    const frame = document.getElementById("new_address")
    frame.src = "/addresses/new"
    frame.classList.remove("d-none")
  }

  handleAddressSelect(event) {
    event.preventDefault()
    const addressId = event.currentTarget.dataset.addressId
    const addressName = event.currentTarget.textContent.trim()
    
    // Update the hidden field
    this.element.querySelector('input[name="ice_time[address_id]"]').value = addressId
    
    // Update the button text span
    this.buttonTarget.querySelector('span').textContent = addressName
  }
} 