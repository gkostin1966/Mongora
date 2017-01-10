class FedoraController < ApplicationController
  before_action :set_fedora, only: [:show]

  # respond_to :json

  # GET /fedora
  # GET /fedora.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fedora
    @fedora = Fedora.rest
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fedora_params
    params.require(:fedora).permit(:name, :identifier, :path)
  end
end
