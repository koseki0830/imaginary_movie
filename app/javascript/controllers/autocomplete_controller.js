import { Controller } from "@hotwired/stimulus"
import Autocomplete from "stimulus-autocomplete"

export default class extends Controller {
  static values = { url: String }

  connect() {
    new Autocomplete(this, {
      input: this.element.querySelector('input[data-autocomplete-target="input"]'),
      url: this.urlValue
    })
  }
}