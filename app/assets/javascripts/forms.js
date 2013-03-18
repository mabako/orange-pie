/**
 * Code based on http://attardi.org/labels2/#css
 */
(function($) {
  function toggleLabel() {
    var input = $(this);
    setTimeout(function() {
      $('label', input.parent()).toggle(!input.val());
    }, 0);
  };

  $(function() {
    $('input, textarea').each(function() { toggleLabel.call(this); });

    $('input, textarea').on('cut', toggleLabel).on('paste', toggleLabel).keydown(toggleLabel);
    $('select').on('change', toggleLabel);
  });

  $(window).load(function() {
    setTimeout(function() {
      $('input, textarea').each(function() { toggleLabel.call(this); });
    }, 0);
  });
})(jQuery);
