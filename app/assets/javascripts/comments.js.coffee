# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document)
  # Create comment form
  .on 'click', '.add-comment-link', (e) ->
    e.preventDefault()
    #Catch data to create right form
    if $(this).data('questionId') == undefined
      answer_id = $(this).data('answerId')
      $('.js-add-comment-form form.new_comment').attr('action', '/answers/'+ answer_id + '/comments')
      create_form_clone =$('.js-add-comment-form').clone().addClass('clone')

      $('#answer-' + answer_id + ' .list-answer-comments').after( create_form_clone.show() )
    else
      question_id = $(this).data('questionId')
      $('.js-add-comment-form form.new_comment').attr('action', '/questions/'+ question_id + '/comments')
      create_form_clone2 =$('.js-add-comment-form').clone().addClass('clone')
      $('.list-question-comments').after( create_form_clone2.show() )
    #Hide 'Create Comment' link
    # It will change when i add popup or dialog window
    $('.add-comment-link').hide()
  # Edit comment form
  .on 'click', '.improve-comment-link', (e) ->
    e.preventDefault()
    # Create edit form to target comment
    comment_id = $(this).data('commentId')
    $('form.edit-comment-form').attr('action', '/comments/' + comment_id)
    $('form.edit-comment-form textarea').text( $('#comment-' + comment_id + ' p').text() )
    edit_form_clone = $('.js-edit-comment-form').clone().addClass('clone')

    $(this).after( edit_form_clone.show() )
    #Hide 'Improve Comment' link
    # It will change when i add popup or dialog window
    $('.improve-comment-link').hide()

