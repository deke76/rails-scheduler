import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    super.connect()
  }

  click() {
    console.log('You clicked the Settings tab')
  }
}
