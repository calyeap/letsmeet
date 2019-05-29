class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [ :show, :index ]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :save, :attend]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    if user_signed_in?
      @my_events = current_user.events.all
      
      @pending_events = current_user.events.where(status: 'pending').order(date: :desc)
      #Working on this^
      @upcoming_events = current_user.events.where(status: 'accepted').order(date: :desc)
      @events_created_future = current_user.events.future.order(date: :desc)
      @events_created_past = current_user.events.past.order(date: :desc)
    end
    # @events_invited = Event.joins(:attendances).where(attendances:
    #                                 {'user_id' => current_user.id})
    # @events_invited_future = @events_invited.future.order(date: :desc)
    # @events_invited_past = @events_invited.past.order(date: :desc)
    
  end

  # GET /events/1
  # GET /events/1.json
  def show
  
  end

  # GET /events/new
  def new
    @event = current_user.events.build
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /events/1/edit
  def edit

  end

  def create
    @event = User.first.events.build
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attend
  @event.attendees << current_user
  @event.save
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def attendance_params
      params.require(:attendees)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :creator_id, :user_type, :choices, :date)
    end
end






