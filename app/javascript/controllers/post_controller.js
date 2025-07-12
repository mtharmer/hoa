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

  expand() {
    const postId = this.element.id.split('-')[3]; // Extracting post ID from
    const commentList = document.getElementById(`comment-list-${postId}`);
    const expandButton = document.getElementById(`post-expand-button-${postId}`);
    const expandText = expandButton.querySelector('.expand-text');
    const collapseText = expandButton.querySelector('.collapse-text');

    if (commentList && expandText && collapseText) {
      commentList.classList.toggle('hidden'); // Toggle visibility of the comment list
      expandText.classList.toggle('hidden'); // Toggle visibility of the expand text
      collapseText.classList.toggle('hidden'); // Toggle visibility of the collapse text
    }
  }
}
