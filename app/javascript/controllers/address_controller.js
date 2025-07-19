import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "menu"]

  connect() {
    console.log("Address controller connected!")
  }

  async handleAddressSelect(event) {
    event.preventDefault()
    const addressId = event.currentTarget.dataset.addressId
    const addressName = event.currentTarget.textContent.trim()
    
    console.log("Selected address ID:", addressId)
    console.log("Selected address name:", addressName)
    
    try {
      // Fetch the address details
      const response = await fetch(`/addresses/${addressId}.json`)
      if (!response.ok) throw new Error('Failed to fetch address details')
      const address = await response.json()
      
      console.log("Fetched address data:", address)

      // Update the hidden field
      this.element.querySelector('input[name="ice_time[address_id]"]').value = addressId
      
      // Update the button text span
      this.buttonTarget.querySelector('span').textContent = addressName

      // Update all address fields
      const form = this.element.closest('form')
      console.log("Found form:", form)
      
      if (form) {
        const fields = {
          name: form.querySelector('[name="address[name]"]'),
          unit_number: form.querySelector('[name="address[unit_number]"]'),
          street_number: form.querySelector('[name="address[street_number]"]'),
          street: form.querySelector('[name="address[street]"]'),
          city: form.querySelector('[name="address[city]"]'),
          province: form.querySelector('[name="address[province]"]'),
          country: form.querySelector('[name="address[country]"]'),
          postal_code: form.querySelector('[name="address[postal_code]"]'),
          latitude: form.querySelector('[name="address[latitude]"]'),
          longitude: form.querySelector('[name="address[longitude]"]')
        }
        
        console.log("Found form fields:", fields)
        
        // Update each field
        Object.entries(fields).forEach(([key, field]) => {
          if (field) {
            field.value = address[key] || ""
            console.log(`Updated ${key}:`, field.value)
          } else {
            console.log(`Field not found: ${key}`)
          }
        })
      } else {
        console.log("No form found")
      }
    } catch (error) {
      console.error('Error fetching address details:', error)
    }
  }
} 