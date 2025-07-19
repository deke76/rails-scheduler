import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleSubmit(event) {
    const formData = new FormData(event.target)
    console.log("Form submission data:", Object.fromEntries(formData))
  }
} 