(function($, window, undefined) {
  $(function() {
    $(".liberta-popover").popover({
      placement: 'top',
      trigger: 'hover'
    })

    $(".notification").on("click", function() {
      $this = $(this);
      $.ajax({
        url: '/notification/' + $this.data("for"),
        success: function() {
          $notificationCount = $("#notifications-count");
          count = parseInt($notificationCount.html()) - 1;
          $notificationCount.html(count);
          $this.parent().next(".divider").remove();
          $this.remove();

          if (count == 0) {
            $notificationCount.remove();
            $("#notification-dropdown").append("<li><a>Нямате непрочетени известия</a></li>");
          }
        }
      });
    });

  })
})(jQuery, window);
