import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["nameable"];

  displayFileName(e) {
    console.log("displaying");
    this.nameableTarget.innerText = e.target.value.split("\\").pop();
  }
}
