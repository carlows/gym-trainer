import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["indicator", "submitButton"]

  submit() {
    this.showLoading()
  }

  showLoading() {
    if (this.hasIndicatorTarget) {
      this.indicatorTarget.classList.remove("is-hidden")
    }
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.classList.add("is-loading")
      this.submitButtonTarget.disabled = true
    }
  }

  hideLoading() {
    if (this.hasIndicatorTarget) {
      this.indicatorTarget.classList.add("is-hidden")
    }
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.classList.remove("is-loading")
      this.submitButtonTarget.disabled = false
    }
  }

  // Called when turbo stream response is received
  responseReceived() {
    this.hideLoading()
  }
}
