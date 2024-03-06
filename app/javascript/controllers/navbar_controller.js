import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from 'controllers/utilities'

export default class extends Controller {
  static targets = ['button', 'dropDown', 'nav']
  static values = {
    lgBreakPoint: { type: Number, default: 1024 },
    closedClass: { type: String, default: 'drop-down--closed' }
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
    this.dropDownTarget.classList.toggle('drop-down--closed')
    this.navTarget.classList.toggle('h-nav_drop-down--closed')
  }

  isSmallLayout() {
    return window.screen.width < this.lgBreakPointValue
  }

  isDropDownClosed() {
    return this.dropDownTarget.classList.contains('drop-down--closed')
  }
}
