class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    if user_id = session[:user_id]
      @event = User.find(user_id).created_events.build(event_params)
      if @event.save
        redirect_to event_path(@event)
      else
        render :new
      end
    else
      redirect_to login_path
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def event_happenings
    @event = Event.find(params[:id])
    if user_id = session[:user_id]
      user = User.find(user_id)
      if @event.attendees.include?(user)
        redirect_to root_path
      else
        @event.attendees<<user
        redirect_to event_path(@event)
      end
    else
      redirect_to signin_path
    end
  end

  def event_happenings_destroy
    @event = Event.find(params[:id])
    if user = User.find(session[:user_id])
      @event.attendees.destroy(user)
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
  
  private
    def event_params
      params.require(:event).permit(:location,:description,:name,:date)
    end
end
