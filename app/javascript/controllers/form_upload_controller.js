import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-upload"
export default class extends Controller {
  connect() {
    super.connect()
    console.log('form_upload_controller loaded')
  }
}
