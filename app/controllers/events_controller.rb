class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :current_user, only: [:create, :join, :leave]
  before_action :authenticate, only: [:join, :leave, :new, :edit, :destroy]

  
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    param = event_params
    creator = User.find(param[:creator].to_i)
    param[:event_type] = EventType.find_by_id(param[:event_type].to_i)
    param[:creator] = creator
    @event = Event.new(param)
    @event.attendances << creator
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: t('.success') }
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
        format.html { redirect_to @event, notice: t('.success') }
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
    id = @event.id
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: t('.success')  }
      format.json { head :no_content }
      format.js { render 'delete.js.erb', locals: {id: id}}
    end
  end

  def join
    @event.attendances << @current_user
    respond_to do |format|
      format.js {render 'joined.js.erb'}
    end
  end

  def leave
    @event.attendances.delete(@current_user)
    respond_to do |format|
      format.js {render 'joined.js.erb'}
    end
  end

  def show_type
    type = params[:event_type]
    unless type == ''
      @events = Event.where(event_type: EventType.find(type.to_i))
    else
      @events = Event.all
    end
    respond_to do |format|
      format.js 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :date, :certain_time, :address, :event_type, :creator, :image)
    end
end
