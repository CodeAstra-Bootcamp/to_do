# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@bindMarkingOfTasks = ->
  $('#tasks ul li span.content').unbind('click').click ->
    # $('#' + this.dataset.targetLinkId).click()
    taskEle = $(this).parent()
    taskEle.toggleClass('done')
    $.ajax(
      method: "PUT",
      url: "/tasks/#{taskEle[0].id.split('-')[1]}",
      data: { done: !taskEle.hasClass('done') }
    )

@serializedTaskIds = ->
  ids = []
  for ele in $('#tasks ul li')
    ids.push(ele.id.split("-")[1])
  ids

$ ->
  bindMarkingOfTasks()
  $("#sortable").sortable
    placeholder: "ui-state-highlight"
    handle: ".handle"
    stop: ->
      $.post("/tasks/sort", {ids: serializedTaskIds()})
  $("#sortable").disableSelection()
