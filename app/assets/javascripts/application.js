// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets

function notifyMe(msg) {
	// If it's okay let's create a notification
	if (Notification.permission === "granted") var notification = new Notification(msg); 

  	// Otherwise, we need to ask the user for permission
	else if (Notification.permission !== 'denied') {
		Notification.requestPermission(function (permission) {
			// If the user accepts, let's create a notification
			if (permission === "granted") var notification = new Notification(msg);
		});
	}
}

function scroll_down_activate_chatbar() {
	var el = $('#msg-container');
	if (el.length > 0) {
		el.scrollTop(el[0].scrollHeight);
		document.getElementById("chat-bar").focus();
	}
}