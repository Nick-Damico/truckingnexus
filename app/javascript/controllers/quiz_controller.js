import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from './utilities'

export default class extends Controller {
  static targets = ['answer', 'submit']

  connect() {
    connectedMsg('Quiz')
  }

  enableSubmit() {
    if (this.hasSubmitTarget) {
      this.submitTarget.classList.remove('btn--disabled')
    }
  }
}
