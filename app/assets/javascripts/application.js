//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require_tree .

jQuery.railsAutocomplete.options.showNoMatches = false;

function forEach(parent, selector, fn) {
  return (parent.querySelectorAll(selector) || []).forEach(fn);
}

function changeWish(oldElement, isAdd) {
  var element = oldElement.cloneNode(true);
  var newTitle;
  var newHref;

  if (isAdd) {
    newTitle = 'желани';
    newHref = 'remove_wishlist';
    element.addEventListener('click', function() {
      changeWish(element, false);
    });
  } else {
    newTitle = 'желани';
    newHref = 'add_wishlist';
    element.addEventListener('click', function() {
      changeWish(element, true);
    });
  }

  element.classList.toggle('add-wish');
  element.classList.toggle('is-success');
  element.classList.toggle('remove-wish');
  element.classList.toggle('is-danger');

  if (!element.dataset.text) {
    element.setAttribute('title', newTitle);
  }

  element.setAttribute('href', '/prints/' + element.dataset.printId + '/' + newHref);

  var icon = element.querySelector('.fa');
  icon.classList.toggle('fa-plus');
  icon.classList.toggle('fa-minus');

  if (element.dataset.text) {
    var textNode = element.childNodes[element.childNodes.length - 1];
    textNode.innerText = newTitle;
  }

  oldElement.parentNode.replaceChild(element, oldElement);
}

document.addEventListener('DOMContentLoaded', function() {
  // Handle Bulma Tabs
  forEach(document, '[data-toggle=tab]', function(tabToggler) {
    tabToggler.addEventListener('click', function(event) {
      event.preventDefault();

      var tabContent = document.getElementsByClassName('tab-pane');
      var tablinks = document.getElementsByClassName('tab-link');

      for (var i = 0; i < tabContent.length; i++) {
        tabContent[i].classList.remove('is-active');
      }

      for (var i = 0; i < tablinks.length; i++) {
        tablinks[i].classList.remove('is-active');
      }

      document.getElementById(this.getAttribute('href').substr(1)).classList.add('is-active');
      this.parentNode.classList.add('is-active');
    });
  });

  // Close Bulma Notifications
  forEach(document, '.notification .delete', function(deleter) {
    var notification = deleter.parentNode;
    deleter.addEventListener('click', function() {
      notification.parentNode.removeChild(notification);
    });
  });

  // Open Bulma Modals
  forEach(document, '[data-toggle=modal]', function(toggler) {
    toggler.addEventListener('click', function(event) {
      event.preventDefault();

      var modalId = this.getAttribute('href')
        .split('#', 2)
        .pop();

      var modal = document.getElementById(modalId);
      var html = document.querySelector('html');

      modal.classList.add('is-active');
      html.classList.add('is-clipped');

      forEach(modal, '[data-dismiss=modal], .modal-background', function(dismisser) {
        dismisser.addEventListener('click', function(e) {
          e.preventDefault();
          modal.classList.remove('is-active');
          html.classList.remove('is-clipped');
        });
      });
    });
  });

  // Stars Selector
  forEach(document, '.stars.interactive', function(starsSelector) {
    starsSelector.addEventListener('mousemove', function(e) {
      var stars = (e.clientX - this.getBoundingClientRect().left) / 15;
      stars = Math.round(stars * 2) / 2;
      if (stars > 5) stars = 5;
      if (stars < 0) stars = 0;

      this.className = '';
      this.classList.add('s-' + stars);
      this.classList.add('stars');
      this.classList.add('interactive');

      this.querySelector('input').value = stars;
    });
  });

  // Wishlist selectors
  forEach(document, '.add-wish', function(wishAdder) {
    wishAdder.addEventListener('ajax:success', function() {
      changeWish(this, true);
    });
  });

  forEach(document, '.remove-wish', function(wishRemover) {
    wishRemover.addEventListener('ajax:success', function() {
      changeWish(this, false);
    });
  });
});
