class FedoraResourcesController < ApplicationController
  before_action :set_fedora_resource, only: [:show, :edit, :update, :destroy]

  # GET /fedora_resources
  # GET /fedora_resources.json
  def index
    @fedora_resources = FedoraResource.all
  end

  # GET /fedora_resources/1
  # GET /fedora_resources/1.json
  def show
  end

  # GET /fedora_resources/new
  def new
    @fedora_resource = FedoraResource.new
  end

  # GET /fedora_resources/1/edit
  def edit
  end

  # POST /fedora_resources
  # POST /fedora_resources.json
  def create
    @fedora_resource = FedoraResource.new(fedora_resource_params)

    respond_to do |format|
      if @fedora_resource.save
        format.html { redirect_to @fedora_resource, notice: 'Fedora resource was successfully created.' }
        format.json { render :show, status: :created, location: @fedora_resource }
      else
        format.html { render :new }
        format.json { render json: @fedora_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fedora_resources/1
  # PATCH/PUT /fedora_resources/1.json
  def update
    respond_to do |format|
      if @fedora_resource.update(fedora_resource_params)
        format.html { redirect_to @fedora_resource, notice: 'Fedora resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @fedora_resource }
      else
        format.html { render :edit }
        format.json { render json: @fedora_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fedora_resources/1
  # DELETE /fedora_resources/1.json
  def destroy
    @fedora_resource.destroy
    respond_to do |format|
      format.html { redirect_to fedora_resources_url, notice: 'Fedora resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fedora_resource
      @fedora_resource = FedoraResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fedora_resource_params
      params.require(:fedora_resource).permit(:name, :identifier, :path)
    end
end
