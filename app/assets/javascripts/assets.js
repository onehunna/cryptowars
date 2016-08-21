$(function() {
  if (!$('#indices-new').length) {
    return;
  }

  $('.assets').DataTable();

  $('.pick').on('change', function(e) {
    if ($(this).get(0).checked) {
      var input = $(this).next();
      if (!input.val()) {
        input.val(1);
      }
      input.show().focus();
    }
    else {
      $(this).next().val('').hide();
    }
  });
});
