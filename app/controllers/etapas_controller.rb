class EtapasController < ApplicationController
  before_action :set_etapa, only: %i[ show edit update destroy ]

  # GET /etapas or /etapas.json
  def index
    @etapas = Etapa.all
  end

  # GET /etapas/1 or /etapas/1.json
  def show
  end

  # GET /etapas/new
  def new
    @etapa = Etapa.new
  end

  # GET /etapas/1/edit
  def edit
  end

  # POST /etapas or /etapas.json
  def create
    @etapa = Etapa.new(etapa_params)

    respond_to do |format|
      if @etapa.save
        format.html { redirect_to @etapa, notice: "Etapa was successfully created." }
        format.json { render :show, status: :created, location: @etapa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @etapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etapas/1 or /etapas/1.json
  def update
    respond_to do |format|
      if @etapa.update(etapa_params)
        format.html { redirect_to @etapa, notice: "Etapa was successfully updated." }
        format.json { render :show, status: :ok, location: @etapa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @etapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etapas/1 or /etapas/1.json
  def destroy
    @etapa.destroy!

    respond_to do |format|
      format.html { redirect_to etapas_path, status: :see_other, notice: "Etapa was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etapa
      @etapa = Etapa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etapa_params
      params.require(:etapa).permit(:descricao, :nivel_id, :created_by, :updated_by, :deleted_at)
    end
end
