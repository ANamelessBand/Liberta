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

    function changeWish(operation, element, addButton, removeButton) {
      var $this = $(element);
      var $id = $this.data("for");
      var url = '/prints/' + $id;

      if (operation == "add") {
        url += '/add-wishlist';
        newButton = addButton;
      }
      else if (operation == "remove") {
        url += '/remove-wishlist';
        newButton = removeButton;
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
      var $this = $(this);
      addButton = "<a class='remove-wish btn btn-danger' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-minus'></span> премахни от желани</a>";
      removeButton = "<a class='add-wish btn btn-success' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-plus'></span> добави в желани</a>";
      changeWish("add", this, addButton, removeButton);
    })

    $(document).on("click", ".remove-wish", function() {
      var $this = $(this);
      addButton = "<a class='remove-wish btn btn-danger' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-minus'></span> премахни от желани</a>";
      removeButton = "<a class='add-wish btn btn-success' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-plus'></span> добави в желани</a>";
      changeWish("remove", this, addButton, removeButton);
    })

    $(document).on("click", ".add-wish-xs", function() {
      var $this = $(this);
      addButton = "<a class='remove-wish-xs btn btn-xs btn-danger' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-minus'></span></a>";
      removeButton = "<a class='add-wish-xs btn btn-success' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-plus'></span></a>";
      changeWish("add", this, addButton, removeButton);
    })

    $(document).on("click", ".remove-wish-xs", function() {
      var $this = $(this);
      addButton = "<a class='remove-wish-xs btn btn-xs btn-danger' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-minus'></span></a>";
      removeButton = "<a class='add-wish-xs btn btn-xs btn-success' data-for='"+$this.data("for")+"'><span class='glyphicon glyphicon-plus'></span></a>";
      changeWish("remove", this, addButton, removeButton);
    })
  })
})(jQuery, window);
