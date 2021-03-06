class TitularesController < ApplicationController
  before_action :set_titular, only: [:show, :edit, :update, :destroy]

  # GET /titulares
  # GET /titulares.json
  def index
    @titular = params[:titular] ? Titular.new(titular_params) : Titular.new

    @titulares = Titular.search(@titular)
    @titulares = @titulares.order(:nombre)
    @titulares = @titulares.page(params[:page])
  end

  # GET /titulares/1
  # GET /titulares/1.json
  def show
    @expedientes = policy_scope(@titular.expedientes).page params[:page]
  end

  # GET /titulares/new
  def new
    @titular = Titular.new
  end

  # GET /titulares/1/edit
  def edit
  end

  # POST /titulares
  # POST /titulares.json
  def create
    @titular = Titular.new(titular_params)

    respond_to do |format|
      if @titular.save
        format.html { redirect_to @titular, notice: 'Titular creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @titular }
      else
        format.html { render :new }
        format.json { render json: @titular.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /titulares/1
  # PATCH/PUT /titulares/1.json
  def update
    respond_to do |format|
      if @titular.update(titular_params)
        format.html { redirect_to @titular, notice: 'Titular actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @titular }
      else
        format.html { render :edit }
        format.json { render json: @titular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /titulares/1
  # DELETE /titulares/1.json
  def destroy
    @titular.destroy
    respond_to do |format|
      format.html { redirect_to titulares_url, notice: 'Titular eliminado satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_titular
      @titular = Titular.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def titular_params
      params.require(:titular).permit(:nombre, :dni, :cuit)
    end
end
