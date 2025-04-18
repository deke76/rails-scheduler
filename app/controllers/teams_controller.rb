class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    puts "team_params: #{team_params}"
    @team = Team.new(team_params)
    
    respond_to do |format|
      if @team.save
        @membership = Membership.create!(
          user_id: current_user.id, 
          team_id: @team.id, 
          role: :owner)
        
        format.turbo_stream { 
          turbo_stream.replace "teams", 
            partial: "teams/team", 
            locals: { team: @team }
        }
        format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.turbo_stream {
          turbo_stream.replace "errors",
            partial: "shared/errors",
            locals: { model: @team }
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.turbo_stream {
          turbo_stream.replace dom_id(@team),
            partial: "teams/team",
            locals: { team: @team }
        }
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.turbo_stream {
          turbo_stream.replace "errors",
            partial: "shared/errors",
            locals: { model: @team }
        }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy!

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :logo).tap do |p|
        p[:logo] = params[:team][:logo] if params[:team][:logo].present?
      end
    end
    
end
