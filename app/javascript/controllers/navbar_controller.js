import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from './utilities'

export default class extends Controller {
  static targets = ['button', 'dropDown']
  static values = {
    lgBreakPoint: { type: Number, default: 1024 }
  }

  connect() {
    connectedMsg('Navbar')
  }

  handleClick() {
    this.toggleDropDown()
  }

  handleResize() {
    if (this.isSmallLayout()) return
    if (this.isDropDownClosed()) return

    // Close the drop-down if open on large page resize.
    this.toggleDropDown()
  }

  toggleDropDown() {
    this.dropDownTarget.classList.toggle('hidden')
  }

  isSmallLayout() {
    return window.screen.width < this.lgBreakPointValue
  }

  isDropDownClosed() {
    return this.dropDownTarget.classList.contains('hidden')
  }
}
