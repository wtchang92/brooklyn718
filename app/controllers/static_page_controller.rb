class StaticPageController < ApplicationController
	def home
  		@subscriber = Subscriber.new
  		if defined? @subscriber
  			puts "yeah subscriber works"	
  		end
	end

end
