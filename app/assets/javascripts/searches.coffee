# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  el = '#searchForm'
  dataContainer = $('#searchData')
  if $('#searchData').length > 0
    $(el).on 'ajax:success', (event) ->
      [data, status, xhr] = event.detail
      clearData(dataContainer)
      $('.search-grid').detach()

      if data.length > 0
        $(dataContainer).pagination
          dataSource: data
          pageSize: 10
          ulClassName: 'pagination-menu'
          callback: (data, pagination) ->
            clearData(dataContainer)
            for i in data
              renderData(i)
            return

          for i in data
            renderData(i)
      else
        $('J-paginationjs-page').detach()
        App.utils.errorMessage(I18n.t('searches.no_found'))

    $(el).on 'ajax:error', (e, data, status, xhr) ->
      App.utils.errorMessage(I18n.t('searches.error'))

    clearData = (el) ->
      $(el).each ->
        $('.search-grid').detach()

    renderData = (data) ->
      $(dataContainer).prepend App.utils.render('item', {data: data, user: gon.current_user_id})
