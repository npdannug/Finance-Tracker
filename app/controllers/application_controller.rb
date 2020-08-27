class ApplicationController < ActionController::Base
	include DeviseWhitelistConcern
	
	before_action :authenticate_user!
end
