import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Listen for turbo frame load events
    document.addEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
    // Also listen for turbo stream updates
    document.addEventListener("turbo:stream-render", this.handleStreamRender.bind(this))
  }

  disconnect() {
    // Clean up event listener
    document.removeEventListener("turbo:frame-load", this.handleFrameLoad.bind(this))
    document.removeEventListener("turbo:stream-render", this.handleStreamRender.bind(this))
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

  handleStreamRender(event) {
    // Check if the new_team frame was updated and is now empty
    setTimeout(() => {
      const newTeamFrame = document.getElementById("new_team")
      if (newTeamFrame && !newTeamFrame.innerHTML.trim()) {
        this.show()
      }
    }, 100)
  }

  hide() {
    this.element.style.display = "none"
  }

  show() {
    this.element.style.display = "block"
  }
} 