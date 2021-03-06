class RoutePointsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_route_point, only: [:show, :edit, :update, :destroy]

  # GET /route_points
  # GET /route_points.json
  def index
    @route_points = RoutePoint.all
  end

  # GET /route_points/1
  # GET /route_points/1.json
  def show
  end

  # GET /route_points/new
  def new
    @route_point = RoutePoint.new
  end

  # GET /route_points/1/edit
  def edit
  end

  # POST /route_points
  # POST /route_points.json
  def create
    respond_to do |format|
      format.html {
        @route_point = RoutePoint.new(route_point_params)
        if @route_point.save
          redirect_to @route_point, notice: 'Route point was successfully created.'
        else
          render :new
        end
      }
      format.json {
        route_point_params[:gps_time] = DateTime.parse(route_point_params[:gps_time])
        @route_point = RoutePoint.new(route_point_params)
        if @route_point.save
          render :show, status: :created, location: @route_point
        else
          render json: @route_point.errors, status: :unprocessable_entity
        end
      }
    end
  end

  # POST /route_points_batch.json
  def create_multiple
  	JSON.parse(request.raw_post)['route_points'].each do |point|
      point['gps_time'] = DateTime.parse(point['gps_time'])
      @route_point = RoutePoint.new(point)
      @route_point.save
    end
    @route_points = RoutePoint.all
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  # PATCH/PUT /route_points/1
  # PATCH/PUT /route_points/1.json
  def update
    respond_to do |format|
      if @route_point.update(route_point_params)
        format.html { redirect_to @route_point, notice: 'Route point was successfully updated.' }
        format.json { render :show, status: :ok, location: @route_point }
      else
        format.html { render :edit }
        format.json { render json: @route_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /route_points/1
  # DELETE /route_points/1.json
  def destroy
    @route_point.destroy
    respond_to do |format|
      format.html { redirect_to route_points_url, notice: 'Route point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route_point
      @route_point = RoutePoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_point_params
      params.require(:route_point).permit(:trip_id, :gps_time, :gps_longitude, :gps_latitude, :gps_speed, :cadence)
    end
end
