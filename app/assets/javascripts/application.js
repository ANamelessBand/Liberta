//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require popper
//= require bootstrap
//= require_tree .

jQuery.railsAutocomplete.options.showNoMatches = false;

jQuery.fn.textNodes = function() {
  return this.contents().filter(function() {
    return this.nodeType === Node.TEXT_NODE && this.nodeValue.trim() !== '';
  });
};

function changeWish($this, title, href) {
  $this.toggleClass('add-wish btn-success remove-wish btn-danger');
  $this.attr('title', title);
  $this.attr('href', '/prints/' + $this.data('print-id') + '/' + href);

  if ($this.data('text')) {
    $this.textNodes().replaceWith(' ' + title);
  }

  $this.find('.fa').toggleClass('fa-plus fa-minus');
}

$(function() {
  // Bootstrap Popovers
  $(document)
    .find('[data-toggle=popover]')
    .popover();

  // Wishlist Buttons
  $(document).on('ajax:success', '.add-wish', function() {
    changeWish($(this), 'премахни от желани', 'remove_wishlist');
  });

  $(document).on('ajax:success', '.remove-wish', function() {
    changeWish($(this), 'добави в желани', 'add_wishlist');
  });

  // Stars
  $(document).on('mousemove', '.stars.interactive', function(e) {
    var $this = $(this);
    var $input = $this.children('input');
    var stars = (e.clientX - $this.offset().left) / 15;
    stars = Math.round(stars * 2) / 2;
    if (stars > 5) stars = 5;
    if (stars < 0) stars = 0;

    $this.removeClass();
    $this
      .addClass('s-' + stars)
      .addClass('stars')
      .addClass('interactive');

    $input.val(stars);
  });
});
