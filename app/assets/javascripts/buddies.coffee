# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
	messages = $('#messages')
	buddy_id = messages.data('buddy-id')
	buddyid = messages.data('buddyid')

	scroll_down_activate_chatbar()
	
	App.buddy = App.cable.subscriptions.create {channel: "BuddyChannel", buddy_id: buddy_id},
		connected: ->
		# Called when the subscription is ready for use on the server
			console.log('connected')
			console.log(App.buddy)
		
		disconnected: ->
		# Called when the subscription has been terminated by the server

		received: (data) ->
		# Called when there's incoming data on the websocket for this channel
			$('#messages').append data['html']
			notifyMe(data['message'].content)
			scroll_down_activate_chatbar()

		speak: (content) ->
			@perform 'speak', message: content, buddy_id: buddy_id, buddyid: buddyid

	$(document).on 'keypress', '[data-behavior~=buddy_speaker]', (event) ->
		if event.keyCode is 13 && event.target.value.trim().length != 0 # return = send
			App.buddy.speak event.target.value
			event.target.value = ""
			event.preventDefault()
			
	$( "#send-btn" ).on "click", () ->
		if $( "#chat-bar" ).val().trim().length != 0 # return = send
			App.buddy.speak $( "#chat-bar" ).val()
			$( "#chat-bar" ).val("") 
