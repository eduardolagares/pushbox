class TagsController < ApplicationController
  before_action :set_tag, only: %i[show update destroy]

  # GET /tags
  def index
    authorize :tag, :index?
    @tags = Tag.all

    render json: @tags
  end

  # GET /tags/1
  def show
    authorize :tag, :show?
    render json: @tag
  end

  # POST /tags
  def create
    authorize :tag, :create?
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    authorize :tag, :update?
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    authorize :tag, :destroy?
    @tag.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.permit(%i[name label])
  end
end
