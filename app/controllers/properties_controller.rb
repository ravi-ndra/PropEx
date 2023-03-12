class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /properties or /properties.json
  def index
    @properties = Property.order(:name).paginate(:page => params[:page], :per_page => 4)
  end

  # GET /properties/1 or /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to property_url(@property), notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    if params[:search] .blank?
      redirect_to root_path and return
    else
      @parameter = params[:search].downcase
      @results = Property.where("lower(name) LIKE :search OR lower(description) LIKE :search OR (city) LIKE :search OR (address) LIKE :search ", search: "%#{@parameter}%")
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    @property = Property.find(params[:id])
    @property.user_id = current_user.id
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to property_url(@property), notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.require(:property).permit(:name, :description, :address, :city, :user_id,:buyer_id, :price, images: [])
  end
end
