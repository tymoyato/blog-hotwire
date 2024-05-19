// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
Turbo.session.drive = false
import Tagify from '@yaireo/tagify';

// If you want to use Tagify on a specific input element
document.addEventListener('DOMContentLoaded', () => {
  const input = document.querySelector('input[name="post[tags]"]');
  if (input) {
    new Tagify(input);
  }
});

document.addEventListener('turbo:frame-load', () => {
  const inputs = document.querySelectorAll('input[name="post[tags]"]');
  inputs.forEach((input) => {
    new Tagify(input);
  });
});
