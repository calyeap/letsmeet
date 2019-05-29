class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:show]
  before_action :set_user, only: [:show, :accept_friend, :remove_friend, :request_friend, :decline_friend]

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
    @events_created_future = current_user.events.future.order(date: :desc) if current_user.events.present?
    @events_created_past = current_user.events.past.order(date: :desc)

    # @events_invited = Event.joins(:attendances).where(attendances:
    #                                 {'user_id' => current_user.id})
    # @events_invited_future = @events_invited.future.order(date: :desc)
    # @events_invited_past = @events_invited.past.order(date: :desc)
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

  def request_friend
    current_user.friend_request(@user)
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "You've added #{@user.username.present? ? @user.username : @user.email}" }
      format.js
    end
  end

  def accept_friend
    current_user.accept_request(@user)
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "You've accepted #{@user.username.present? ? @user.username : @user.email}" }
      format.js
    end
  end

  def decline_friend
    current_user.decline_request(@user)
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "You've declined #{@user.username.present? ? @user.username : @user.email}" }
      format.js
    end
  end

  def remove_friend
    current_user.remove_friend(@user)
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "You've removed #{@user.username.present? ? @user.username : @user.email}" }
      format.js
    end
  end



  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username)
  end
end