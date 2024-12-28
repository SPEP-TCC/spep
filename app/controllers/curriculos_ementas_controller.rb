class CurriculosEmentasController < ApplicationController
  before_action :set_curriculo_ementa, only: %i[ show edit update destroy ]

  # GET /curriculos_ementas or /curriculos_ementas.json
  def index
    @curriculos_ementas = CurriculoEmenta.all
  end

  # GET /curriculos_ementas/1 or /curriculos_ementas/1.json
  def show
  end

  # GET /curriculos_ementas/new
  def new
    @curriculo_ementa = CurriculoEmenta.new
  end

  # GET /curriculos_ementas/1/edit
  def edit
  end

  # POST /curriculos_ementas or /curriculos_ementas.json
  def create
    @curriculo_ementa = CurriculoEmenta.new(curriculo_ementa_params)

    respond_to do |format|
      if @curriculo_ementa.save
        format.html { redirect_to @curriculo_ementa, notice: "Curriculo ementa was successfully created." }
        format.json { render :show, status: :created, location: @curriculo_ementa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @curriculo_ementa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /curriculos_ementas/1 or /curriculos_ementas/1.json
  def update
    respond_to do |format|
      if @curriculo_ementa.update(curriculo_ementa_params)
        format.html { redirect_to @curriculo_ementa, notice: "Curriculo ementa was successfully updated." }
        format.json { render :show, status: :ok, location: @curriculo_ementa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @curriculo_ementa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curriculos_ementas/1 or /curriculos_ementas/1.json
  def destroy
    @curriculo_ementa.destroy!

    respond_to do |format|
      format.html { redirect_to curriculos_ementas_path, status: :see_other, notice: "Curriculo ementa was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculo_ementa
      @curriculo_ementa = CurriculoEmenta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def curriculo_ementa_params
      params.require(:curriculo_ementa).permit(:descricao, :ano_documento, :created_by, :updated_by, :deleted_at)
    end
end
