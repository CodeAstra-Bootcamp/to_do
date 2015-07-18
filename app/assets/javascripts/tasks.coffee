# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@bindMarkingOfTasks = ->
  $('#tasks ul li span').unbind('click').click ->
    $('#' + this.dataset.targetLinkId).click()

$ ->
  bindMarkingOfTasks()