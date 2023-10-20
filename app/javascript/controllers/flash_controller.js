import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from './utilities'

export default class extends Controller {
  static targets = ['container']

  connect() {
    connectedMsg('Flash Controller')
  }

  dismiss() {
    if (this.hasContainerTarget) {
      this.containerTarget.classList.add('flash-dismiss-animation')

      this.containerTarget.addEventListener('transitionend', () => {
        if (this.hasContainerTarget) {
          this.containerTarget.remove()
        }
      })
    }
  }
}
