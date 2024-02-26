import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from './utilities'

export default class ReviewController extends Controller {
  static targets = ['rating', 'ratingStar', 'ratingField', 'ratingContainer']
  static classes = ['activeStar']

  connect() {
    connectedMsg('Review')
  }

  ratingFieldTargetconnected(target) {}

  onClickRatingStar(e) {
    let target = e.target
    if (target.tagName === 'path') {
      target = e.target.parentNode
    }

    this.ratingFieldTarget.setAttribute(
      'value',
      this.#starIconIndexValue(target) + 1
    )
  }

  onMouseOverRatingStar(e) {
    if (!this.#isStarIcon(e.target)) {
      return
    }

    this.#activateStarsUpTo(this.#starIconIndexValue(e.target))
  }

  onMouseOutRatingStar(e) {
    if (e.target !== this.ratingContainerTarget) {
      return
    }

    this.#activateStarsUpTo(this.ratingFieldTarget.value - 1)
  }

  #activateStarsUpTo(to) {
    for (let i = 0; i < this.ratingStarTargets.length; ++i) {
      if (i > to && this.#isStarIconActive(this.ratingStarTargets[i])) {
        this.ratingStarTargets[i].classList.remove(this.activeStarClass)
      }

      if (i <= to && !this.#isStarIconActive(this.ratingStarTargets[i])) {
        this.ratingStarTargets[i].classList.add(this.activeStarClass)
      }
    }
  }

  #isStarIconActive(icon) {
    return icon.classList.contains(this.activeStarClass)
  }

  #isStarIcon(target) {
    return target.tagName === 'svg'
  }

  #starIconIndexValue(target) {
    return this.ratingStarTargets.indexOf(target)
  }
}
