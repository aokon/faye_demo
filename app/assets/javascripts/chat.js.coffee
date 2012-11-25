# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Logger = {
  incoming: (message, callback) ->
    console.log "incoming message #{JSON.stringify(message)}"
    callback(message)
  ,
  outgoing: (message, callback) ->
    console.log "outgoing message #{JSON.stringify(message)}"
    callback(message)
}

$ ->
  fayeClient = new Faye.Client("http://localhost:4000/faye")
  fayeClient.addExtension Logger

  subscription = fayeClient.subscribe "/messages/new", (data) ->
    $('<li/>', { text: data }).appendTo($('.messages'))

  subscription.callback ->
    console.log "Subscription is active"

  subscription.errback (error)->
    console.log error

  $('#new_message .btn').on 'click', (event) ->
    event.preventDefault()
    content = $('#new_message #message_content').val()

    publication = fayeClient.publish '/messages/new', content
    publication.callback -> console.log "message was received"
    publication.errback (error) -> console.log error




