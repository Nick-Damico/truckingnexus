import { Controller } from '@hotwired/stimulus'
import { connectedMsg } from './utilities'

export default class ReviewController extends Controller {
  connect() {
    connectedMsg('Review')
  }
}
