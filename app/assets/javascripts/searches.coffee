# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  el = '#searchForm'
  dataContainer = $('#searchData')

  if $('#searchData').length > 0

    $('.js-btn-submit').on 'click', ->
      submitForm()

    $('.js-select-submit').on 'change', ->
      submitForm()

    submitForm = () ->
      $.ajax({
        type: "GET",
        url: $(el).attr('action'),
        data: $(el).serialize(),
        success:(data) ->
#          console.log data
          handleData(data)
          return false
        error:(data) ->
          App.utils.errorMessage(I18n.t('searches.error'))
      })

    handleData = (data) ->
      clearData(dataContainer)
      $('.search-grid').detach()

      if data.length > 0
        $('.paginationjs-pages').detach()
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
        $('.paginationjs-pages').detach()
        App.utils.errorMessage(I18n.t('searches.no_found'))

    clearData = (el) ->
      $(el).each ->
        $('.search-grid').detach()

    renderData = (data) ->
      $(dataContainer).prepend App.utils.render('item', {data: data, user: gon.current_user_id})
