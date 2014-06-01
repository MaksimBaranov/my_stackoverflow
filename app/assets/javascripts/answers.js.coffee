# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('form.add-answer-form').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    # Insert JQuery template for answer, asserts and passes JSON-data
    $('.list-answers li:last').after($.tmpl("templates/answer", { id: answer.id, question_id: answer.question_id, vote_id: answer.vote.id, text: answer.text}))
    # Add to answer listing of attached files
    $.each answer.attachments, (index, attach) ->
      # Constructing li>a elements
      array = attach.file.url.split("/")
      file_name = array[array.length - 1]
      link = $('<a>' + file_name + '</a>').appendTo('.list-attachments')
      link.attr("href", attach.file.url).wrap("<li></li>")
    reload_edit()
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.answer-error-messages').append( value + '<br>')
