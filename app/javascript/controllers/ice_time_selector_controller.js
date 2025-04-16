import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["day", "time"]

  connect() {
    console.log("ice time selector controller connected")
    // Initialize with the current selected days if any
    const selectedDays = this.element.querySelectorAll('input[name="ice_time[day][]"]:checked')
    selectedDays.forEach(day => this.selectDay(day.value))
  }

  select(event) {
    console.log("select called", event)
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

  selectTime(event) {
    console.log("selectTime called")
    const time = event.currentTarget.dataset.time
    this.toggleTime(time)
    
    // Update the hidden radio button
    const radio = this.element.querySelector(`input[value="${time}"]`)
    if (radio) {
      radio.checked = true
      radio.dispatchEvent(new Event('change'))
    }
  }

  toggleTime(time) {
    console.log("toggleTime called with:", time)
    // Toggle selected class for the clicked time
    const selectedTime = this.timeTargets.find(target => target.dataset.time === time)
    if (selectedTime) {
      selectedTime.classList.toggle('bg-primary')
      selectedTime.classList.toggle('text-white')
    }
  }
} 