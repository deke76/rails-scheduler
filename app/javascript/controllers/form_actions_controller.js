import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["deleteButton", "saveButton"]
  static values = { hasChanges: Boolean }

  connect() {
    this.hasChangesValue = false
    this.setupFormListeners()
  }

  setupFormListeners() {
    const form = this.element.closest('form')
    if (form) {
      // Listen to all form inputs
      const inputs = form.querySelectorAll('input, textarea, select')
      inputs.forEach(input => {
        input.addEventListener('input', () => this.markAsChanged())
        input.addEventListener('change', () => this.markAsChanged())
        input.addEventListener('keyup', () => this.markAsChanged())
      })
      
      // Also listen to form-level events
      form.addEventListener('input', () => this.markAsChanged())
      form.addEventListener('change', () => this.markAsChanged())
    }
  }

  markAsChanged() {
    this.hasChangesValue = true
  }

  hasChangesValueChanged() {
    if (this.hasChangesValue) {
      this.deleteButtonTarget.classList.add('d-none')
      this.saveButtonTarget.classList.remove('d-none')
    } else {
      this.deleteButtonTarget.classList.remove('d-none')
      this.saveButtonTarget.classList.add('d-none')
    }
  }
} 