class SimulatorController < ApplicationController

  def index
  end

  def simulate
    commands = JSON.parse(simulate_params[:commands])
    results = CommandExecutorService.new(commands).execute

    render json: { results: results }, status: 200
  end

  private
    def simulate_params
      params.permit(:commands)
    end
end
