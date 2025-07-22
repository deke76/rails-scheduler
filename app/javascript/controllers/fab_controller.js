import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("🔵 FAB Controller connected")
    // Listen for turbo frame load events
    document.addEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
    // Also listen for turbo stream updates
    document.addEventListener("turbo:stream-render", this.handleStreamRender.bind(this))
    // Check initial state
    this.checkFormActions()
  }

  disconnect() {
    console.log("🔵 FAB Controller disconnected")
    // Clean up event listener
    document.removeEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
    document.removeEventListener("turbo:stream-render", this.handleStreamRender.bind(this))
  }

  handleFrameLoad(event) {
    console.log("🔵 FAB: Frame loaded", event.target.id)
    // Check for form actions after any frame loads
    setTimeout(() => {
      this.checkFormActions()
    }, 100)
  }

  handleStreamRender(event) {
    console.log("🔵 FAB: Stream rendered")
    // Check for form actions after stream renders
    setTimeout(() => {
      this.checkFormActions()
    }, 100)
  }

  checkFormActions() {
    console.log("🔵 FAB: Checking for form actions...")
    // Look for form actions on the page, but exclude the FAB itself
    const formActions = document.querySelectorAll('[data-form-actions-target]')
    console.log("🔵 FAB: All form actions found:", formActions)
    
    // Filter out the FAB element itself
    const formActionsExcludingFab = Array.from(formActions).filter(element => {
      const isFab = element.closest('#fab') !== null
      console.log("🔵 FAB: Element:", element, "is FAB:", isFab)
      return !isFab
    })
    
    console.log("🔵 FAB: Form actions excluding FAB:", formActionsExcludingFab)
    
    if (formActionsExcludingFab.length > 0) {
      console.log("🔵 FAB: Form actions found, hiding FAB")
      // Form actions found, hide the FAB
      this.hide()
    } else {
      console.log("🔵 FAB: No form actions found, showing FAB")
      // No form actions found, show the FAB
      this.show()
    }
  }

  hide() {
    console.log("🔵 FAB: Hiding FAB")
    console.log("🔵 FAB: Current display before hide:", this.element.style.display)
    this.element.classList.add('d-none')
    console.log("🔵 FAB: Display after hide:", this.element.style.display)
    console.log("🔵 FAB: Computed display:", window.getComputedStyle(this.element).display)
  }

  show() {
    console.log("🔵 FAB: Showing FAB")
    console.log("🔵 FAB: Current display before show:", this.element.style.display)
    this.element.classList.remove('d-none')
    console.log("🔵 FAB: Display after show:", this.element.style.display)
    console.log("🔵 FAB: Computed display:", window.getComputedStyle(this.element).display)
  }
} 