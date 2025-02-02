import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    super.connect()
    console.log('Do what you want here.')
  }

  click() {
    console.log('You clicked the Settings tab')
  }
}
