import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Listen for turbo frame load events
    document.addEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
  }

  disconnect() {
    // Clean up event listener
    document.removeEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
  }

  handleFrameLoad(event) {
    // Check if the loaded frame is the new form frame
    const frameId = event.target.id
    if (frameId === "new_team" || frameId === "new_ice_time" || frameId === "new_address") {
      // Hide the FAB if the frame has content
      if (event.target.innerHTML.trim()) {
        this.hide()
      } else {
        this.show()
      }
    }
  }

  hide() {
    this.element.style.display = "none"
  }

  show() {
    this.element.style.display = "block"
  }
} 