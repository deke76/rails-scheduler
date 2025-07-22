import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Listen for turbo frame load events
    document.addEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
    // Also listen for turbo stream updates
    document.addEventListener("turbo:stream-render", this.handleStreamRender.bind(this))
    // Check initial state
    this.checkFormActions()
  }

  disconnect() {
    // Clean up event listener
    document.removeEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
    document.removeEventListener("turbo:stream-render", this.handleStreamRender.bind(this))
  }

  handleFrameLoad(event) {
    // Check for form actions after any frame loads
    setTimeout(() => {
      this.checkFormActions()
    }, 100)
  }

  handleStreamRender(event) {
    // Check for form actions after stream renders
    setTimeout(() => {
      this.checkFormActions()
    }, 100)
  }

  checkFormActions() {
    // Look for form actions on the page, but exclude the FAB itself
    const formActions = document.querySelectorAll('[data-form-actions-target]')
    
    // Filter out the FAB element itself
    const formActionsExcludingFab = Array.from(formActions).filter(element => {
      const isFab = element.closest('#fab') !== null
      return !isFab
    })
    
    if (formActionsExcludingFab.length > 0) {
      // Form actions found, hide the FAB
      this.hide()
    } else {
      // No form actions found, show the FAB
      this.show()
    }
  }

  hide() {
    this.element.classList.add('d-none')
  }

  show() {
    this.element.classList.remove('d-none')
  }
} 