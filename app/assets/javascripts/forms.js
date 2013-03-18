/**
 * Code based on http://attardi.org/labels2/#css
 */
(function($) {
  function toggleLabel() {
    var input = $(this);
    setTimeout(function() {
      $('label', input.parent()).toggle(!input.val());

      // autocomplete fix thing
      var pass = $('input[type=password]');
      if(pass.length >= 1) {
        for(var i = 0; i < pass.length; ++ i) {
          $('label', $(pass[i]).parent()).toggle(!$(pass[i]).val());
        }
      }
    }, 0);
  };

  $(function() {
    $('input, textarea').each(function() { toggleLabel.call(this); });

    $('input, textarea').on('cut', toggleLabel).on('paste', toggleLabel).change(toggleLabel).keydown(toggleLabel);
    $('select').on('change', toggleLabel);
  });

  $(window).load(function() {
    setTimeout(function() {
      $('input, textarea').each(function() { toggleLabel.call(this); });
    }, 0);
  });
})(jQuery);
