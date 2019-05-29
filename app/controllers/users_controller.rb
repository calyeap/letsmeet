class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def index
    @users = User.all
    @events_created_future = current_user.events.future.order(date: :desc)
    @events_created_past = current_user.events.past.order(date: :desc)
    @events_invited = Event.joins(:attendances).where(attendances:
                                    {'user_id' => current_user.id})
    @events_invited_future = @events_invited.future.order(date: :desc)
    @events_invited_past = @events_invited.past.order(date: :desc)

    
    @pending_events = current_user.events.where(status: 'pending').order(date: :desc)

  end

  def show
    @user = @current_user
    @events_created_future = @user.events.future.order(date: :desc)
    @events_created_past = @user.events.past.order(date: :desc)

    @events_invited = Event.joins(:attendances).where(attendances:
                                    {'user_id' => current_user.id})
    @events_invited_future = @events_invited.future.order(date: :desc)
    @events_invited_past = @events_invited.past.order(date: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:info] = "Account creation successful!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username)
    end
end