# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('form.add-answer-form').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('.list-answers li:last').after($.tmpl("templates/answer", { id: answer.id, question_id: answer.question_id, vote_id: answer.vote.id, text: answer.text}))
    $.each answer.attachments, (index, attach) ->
      link = $('.list-attachments').append('<li><a href="/">' + attach.file.url + '</a></li>')
      # link.attr('href', attach.file.url)
    reload_edit()
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.answer-error-messages').append( value + '<br>')
