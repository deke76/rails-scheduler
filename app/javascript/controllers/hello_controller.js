import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log('hello_controller connected')
    this.element.textContent = "Hello World!"
  }
}
