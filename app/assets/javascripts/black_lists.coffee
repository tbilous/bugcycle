# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $(document).on 'ajax:success', '.js-filter-off', (event) ->
    [data, status, xhr] = event.detail
    container = $(@).closest('.js-filter-block')
    item_id = $(@).data('item')
    html =  App.utils.render('btns/filter_on', { item_id: item_id })
    $(@).detach()
    $(container).append(html)


  $(document).on 'ajax:success', '.js-filter-on', (event) ->
    [data, status, xhr] = event.detail
    container = $(@).closest('.js-filter-block')
    html =  App.utils.render('btns/filter_off', data.filter)
    $(@).detach()
    $(container).append(html)
