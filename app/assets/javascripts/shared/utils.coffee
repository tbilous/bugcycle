App = window.App = {}
#= require handlebars
#= require_tree ./templates

# Handlebars helpers
Handlebars.registerHelper 'i18n_t', (a) ->
  I18n.t(a)

Handlebars.registerHelper 'if_eq', (a, b, opts) ->
  if a == b
    opts.fn this
  else
    opts.inverse this

Handlebars.registerHelper 'if_noeq', (a, b, opts) ->
  if a != b
    opts.fn this
  else
    opts.inverse this

Handlebars.registerHelper 'inc', (value, options) ->
  parseInt(value) + 1

App.utils =
  successMessage: (message) ->
    return unless message
    toastr.success(message)

  errorMessage: (message) ->
    return unless message
    toastr.error(message)

  ajaxErrorHandler: (e, data) ->
    message = 'Unknown error'
    if data.status == 401
      message = 'Sign in, please'
    else if data.status == 404
      message = 'Not found'
    else if data.status >= 400 && data.status < 500
      message = data.responseText
    else if data.status == 200
      message = data.status
      console.log(data.status)
    App.utils.errorMessage message

  render: (template, data) ->
    JST[template](data)

$ ->
  App.utils.successMessage(App.flash?.success)
  App.utils.errorMessage(App.flash?.error)
