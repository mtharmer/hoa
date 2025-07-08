import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  add() {
    const form = document.getElementById('upload-document-form');
    const btn = document.getElementById('upload-document-button');
    if (btn) {
      btn.classList.add('hidden'); // Hide the button
    }
    if (form) {
      form.classList.remove('hidden'); // Simulate a click on the button
    }
  }

  cancel() {
    const form = document.getElementById('upload-document-form');
    const btn = document.getElementById('upload-document-button');
    if (btn) {
      btn.classList.remove('hidden'); // Show the button again
    }
    if (form) {
      form.classList.add('hidden'); // Simulate a click on the button
    }
  }
}
