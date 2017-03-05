class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	
	def auto_html(m)
		img_filter = AutoHtml::Image.new
		link_filter = AutoHtml::Link.new(target: '_blank')
		emoji_filter = AutoHtml::Emoji.new	  
		base_format = AutoHtml::Pipeline.new(img_filter, emoji_filter, link_filter)
		base_format.call(m).html_safe
	end	
	helper_method :auto_html
end