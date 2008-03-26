# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	# Pick a unique cookie name to distinguish our session data from others'
	session :session_key => '_admin_session_id'

	def self.enable_sticker_printing
		Sticker::Proxy.inject_into(self)
	end

	helper :date
end
