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

    function changeWish(operation, element) {
      $this = $(element);
      $id = $this.data("for")

      url = '/prints/' + $id
      if (operation == "add") {
        url += '/add-wishlist';
        newButton = "<a class='remove-wish btn btn-danger' data-for='"+$id+"'><span class='glyphicon glyphicon-minus'></span> премахни от желани</a>";
      }
      else if (operation == "remove") {
        url += '/remove-wishlist';
        newButton = "<a class='add-wish btn btn-success' data-for='"+$id+"'><span class='glyphicon glyphicon-plus'></span> добави в желани</a>";
      }

      $.ajax({
        url: url,
        success: function() {
          $this.after(newButton);
          $this.remove();
        }
      })
    }

    $(document).on("click", ".add-wish", function() {
      changeWish("add", this);
    })

    $(document).on("click", ".remove-wish", function() {
      changeWish("remove", this);
    })
  })
})(jQuery, window);
