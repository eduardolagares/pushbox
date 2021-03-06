class SystemsController < ApplicationController
  before_action :set_system, only: %i[show update destroy]

  # GET /systems
  def index
    authorize :system, :index?

    @systems = System.all

    render json: @systems
  end

  # GET /systems/1
  def show
    authorize :system, :show?
    render json: @system
  end

  # POST /systems
  def create
    authorize :system, :create?
    @system = System.new(system_params)

    if @system.save
      render json: @system, status: :created, location: @system
    else
      render json: @system.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /systems/1
  def update
    authorize :system, :update?
    if @system.update(system_params)
      render json: @system
    else
      render json: @system.errors, status: :unprocessable_entity
    end
  end

  # DELETE /systems/1
  def destroy
    authorize :system, :destroy?
    @system.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_system
    @system = System.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def system_params
    params.permit(:name, :label)
  end
end
