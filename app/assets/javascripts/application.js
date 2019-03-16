//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require popper
//= require bootstrap
//= require_tree .

jQuery.railsAutocomplete.options.showNoMatches = false;

$(function() {
  $(document)
    .find('[data-toggle=popover]')
    .popover();

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
