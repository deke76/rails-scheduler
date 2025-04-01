import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["day"]

  connect() {
    console.log("Day selector controller connected")
    // Initialize with the current selected days if any
    const selectedDays = this.element.querySelectorAll('input[name="ice_time[day][]"]:checked')
    selectedDays.forEach(day => this.selectDay(day.value))
  }

  select(event) {
    const day = event.currentTarget.dataset.day
    this.toggleDay(day)
    
    // Update the hidden checkbox
    const checkbox = this.element.querySelector(`input[value="${day}"]`)
    if (checkbox) {
      checkbox.checked = !checkbox.checked
      checkbox.dispatchEvent(new Event('change'))
    }
  }

  toggleDay(day) {
    // Toggle selected class for the clicked day
    const selectedDay = this.dayTargets.find(target => target.dataset.day === day)
    if (selectedDay) {
      selectedDay.classList.toggle('bg-primary')
      selectedDay.classList.toggle('text-white')
    }
  }
} 