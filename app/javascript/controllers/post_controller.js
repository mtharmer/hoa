import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  comment() {
    const postId = this.element.id.split('-')[2] // Extracting post ID from
    const commentForm = document.getElementById(`comment-form-${postId}`);
    if (commentForm) {
      commentForm.classList.remove('hidden'); // Simulate a click on the button
    }
  }

  cancel() {
    const postId = this.element.id.split('-')[2] // Extracting post ID from
    const commentForm = document.getElementById(`comment-form-${postId}`);
    if (commentForm) {
      commentForm.classList.add('hidden'); // Simulate a click on the button
    }
  }
}
