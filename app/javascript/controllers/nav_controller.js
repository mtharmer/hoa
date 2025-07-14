import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["adminButton", "adminSection", "accountButton", "accountSection"]
  toggleAdmin() {
    if (this.adminSectionTarget.classList.contains('hidden')) {
      this.showAdmin();
    } else {
      this.hideAdmin();
    }
  }

  showAdmin() {
    this.adminSectionTarget.classList.remove('hidden'); // Show the admin section
  }

  hideAdmin(event) {
    if (event && (this.adminSectionTarget.contains(event.target) || this.adminButtonTarget.contains(event.target))) {
      return; // Do not hide if the click is inside the admin section or on the button
    }
    this.adminSectionTarget.classList.add('hidden'); // Hide the admin section
  }

  toggleAccount() {
    if (this.accountSectionTarget.classList.contains('hidden')) {
      this.showAccount();
    } else {
      this.hideAccount();
    }
  }

  showAccount() {
    this.accountSectionTarget.classList.remove('hidden'); // Show the admin section
  }

  hideAccount(event) {
    if (event && (this.accountSectionTarget.contains(event.target) || this.accountButtonTarget.contains(event.target))) {
      return; // Do not hide if the click is inside the admin section or on the button
    }
    this.accountSectionTarget.classList.add('hidden'); // Hide the admin section
  }
}
