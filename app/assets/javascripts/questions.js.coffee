# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('#edit-answer-' + answer_id).show()

ready = =>

              this.reload_edit = () ->
                $('.edit-answer-link').click (e) ->
                  e.preventDefault()
                  $(this).hide()
                  answer_id = $(this).data('answerId')
                  $('#edit-answer-' + answer_id).show()

$(document).ready(ready)
