import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from 'controllers/utilities'

export default class extends Controller {
  static targets = ['answer', 'submit']

  connect() {
    connectedMsg('Quiz')
  }

  allowSubmit() {
    if (this.hasSubmitTarget && this.answerSelected()) {
      this.enableSubmit()
    }
  }

  answerSelected() {
    let answerSelected = false

    for (let i = 0; i < this.answerTargets.length; i++) {
      if (this.answerTargets[i].checked) {
        answerSelected = true
        break
      }
    }

    return answerSelected
  }

  enableSubmit() {
    this.submitTarget.classList.remove('btn--disabled')
    this.submitTarget.removeAttribute('disabled')
  }
}
