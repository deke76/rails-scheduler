import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "menu"]

  connect() {
    console.log("Team controller connected!")
  }

  handleNewTeam(event) {
    event.preventDefault()
    const frame = document.getElementById("new_team")
    frame.src = "/teams/new"
    frame.classList.remove("d-none")
  }

  handleTeamSelect(event) {
    event.preventDefault()
    event.stopPropagation()
    const teamId = event.currentTarget.dataset.teamId
    const teamName = event.currentTarget.textContent.trim()
    
    // Update the hidden field
    this.element.querySelector('input[name="ice_time[team_id]"]').value = teamId
    
    // Update the button text span
    this.buttonTarget.querySelector('span').textContent = teamName
  }
} 