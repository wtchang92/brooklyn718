class SubscribersController < ApplicationController
before_action :authenticate_admin!, :except => [:create]
	def index
    @subscribers = Subscriber.all
  end

	def create
		@subscriber = Subscriber.new(subscriber_params)
 respond_to do |format|
      if @subscriber.save
        format.html { redirect_to root_path, notice: 'Subscribed!' }
        
      else
        format.html { redirect_to root_path, notice: 'INVALID EMAIL' }
        
      end
    end



    
  end

  def show
  end

  def destroy
    @subscriber.destroy
    respond_to do |format|
      format.html { redirect_to subscribers_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
  def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
