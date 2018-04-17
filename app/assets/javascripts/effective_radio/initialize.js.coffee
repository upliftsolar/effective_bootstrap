$(document).on 'change', '[data-toggle=cards] input[type=radio]', (event) ->
  $input = $(event.currentTarget)
  return unless $input.is(':checked')

  $card = $input.closest('.card')
  return unless $card.length > 0

  $cards = $input.closest('.card-deck').children('.card')
  return unless $cards.length > 0

  $cards.removeClass('active').removeClass('border-secondary')
  $cards.find('.card-header').removeClass('bg-secondary text-white')

  $card.addClass('active').addClass('border-secondary')
  $card.find('.card-header').addClass('bg-secondary text-white')
  true

$(document).on 'click', '[data-toggle=cards] [data-toggle=card]', (event) ->
  $card = $(event.currentTarget).closest('.card')
  return unless $card.length > 0

  val = $card.find('input:radio').val()
  $card.find('input:radio').val([val]).trigger('change')
  false
