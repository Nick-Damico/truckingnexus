import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from 'controllers/utilities'

export default class extends Controller {
  static targets = ['container']
  static values = {
    level: String
  }

  connect() {
    connectedMsg('Flash Controller')
  }

  containerTargetConnected(_target) {
    if (this._isAlertMsg()) return

    this._autoClose(3000)
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

  _isAlertMsg() {
    return this.hasLevelValue && this.levelValue === 'alert'
  }

  _autoClose(timeout) {
    setTimeout(() => this.dismiss(), timeout)
  }
}
