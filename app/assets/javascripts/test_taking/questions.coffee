# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.Choice').click (event) ->
  $('.Choice_List').addClass('active')
  $('.Choice').removeClass('active').removeClass('margin')
  $id = $(this).data("choice-id");
  console.log("Choice ##{$id} Selected")
  $('.Button--next').fadeOut(300)
  $(this).addClass('active').addClass('margin')
  $('.Button--next', this).delay(700).fadeIn(300)


$('.Button--next').click (event) ->
  event.stopPropagation();
  $selectedAnswer = $(this).parent().data("choice-id");
  sendResponse $selectedAnswer


sendResponse = (id) ->
  answer = makeInput {
    type: "hidden",
    name: "response[selected_choice_id]",
    value: id
  }
  form = makeForm()
  form.append answer
  console.log("Choice ##{id} Choosen")
  form.appendTo("body").submit()


makeForm = ->
  $("form.choice-form").remove()
  form = $ "<form>", {
    method: "post",
    class: "choice-form"
    action: "#{window.location.pathname}/respond",
    }
  utfInput = makeInput {
    type: "hidden",
    name: "utf8",
    value: "&#x2713"
  }
  authInput = makeInput {
    type: "hidden",
    name: "authenticity_token",
    value: $("meta[name=csrf-token]").attr("content")
  }
  form.append utfInput, authInput

makeInput = (options) ->
  $("<input>", options)
