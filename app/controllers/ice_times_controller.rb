class IceTimesController < ApplicationController
  before_action :set_ice_time, only: %i[ show edit update destroy ]

  # GET /ice_times or /ice_times.json
  def index
    @ice_times = IceTime.all
  end

  # GET /ice_times/1 or /ice_times/1.json
  def show
  end

  # GET /ice_times/new
  def new
    @teams = current_user.memberships
    @addresses = Address.all
    @ice_time = IceTime.new
  end

  # GET /ice_times/1/edit
  def edit
    @addresses = Address.all
  end

  # POST /ice_times or /ice_times.json
  def create
    @ice_time = IceTime.new(ice_time_params)

    respond_to do |format|
      if @ice_time.save
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.replace("new_ice_time", partial: "ice_times/ice_time", locals: { ice_time: @ice_time }),
            turbo_stream.replace("ice_times", partial: "ice_times/ice_times", locals: { ice_times: IceTime.all })
          ]
        }
        format.html { redirect_to @ice_time, notice: "Ice time was successfully created." }
        format.json { render :show, status: :created, location: @ice_time }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("new_ice_time", 
            partial: "ice_times/form", 
            locals: { ice_time: @ice_time })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ice_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ice_times/1 or /ice_times/1.json
  def update
    respond_to do |format|
      if @ice_time.update(ice_time_params)
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(dom_id(@ice_time),
            partial: "ice_times/ice_time",
            locals: { ice_time: @ice_time })
        }
        format.html { redirect_to @ice_time, notice: "Ice time was successfully updated." }
        format.json { render :show, status: :ok, location: @ice_time }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(dom_id(@ice_time),
            partial: "ice_times/form",
            locals: { ice_time: @ice_time })
        }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ice_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ice_times/1 or /ice_times/1.json
  def destroy
    @ice_time.destroy!

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.remove(@ice_time)
      }
      format.html { redirect_to ice_times_path, status: :see_other, notice: "Ice time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ice_time
      @ice_time = IceTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ice_time_params
      params.require(:ice_time).permit(:day, :ice_time, :length, :team_id, :address_id)
    end
end
