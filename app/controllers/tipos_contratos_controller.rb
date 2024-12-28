class TiposContratosController < ApplicationController
  before_action :set_tipo_contrato, only: %i[ show edit update destroy ]

  # GET /tipos_contratos or /tipos_contratos.json
  def index
    @tipos_contratos = TipoContrato.all
  end

  # GET /tipos_contratos/1 or /tipos_contratos/1.json
  def show
  end

  # GET /tipos_contratos/new
  def new
    @tipo_contrato = TipoContrato.new
  end

  # GET /tipos_contratos/1/edit
  def edit
  end

  # POST /tipos_contratos or /tipos_contratos.json
  def create
    @tipo_contrato = TipoContrato.new(tipo_contrato_params)

    respond_to do |format|
      if @tipo_contrato.save
        format.html { redirect_to @tipo_contrato, notice: "Tipo contrato was successfully created." }
        format.json { render :show, status: :created, location: @tipo_contrato }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tipo_contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipos_contratos/1 or /tipos_contratos/1.json
  def update
    respond_to do |format|
      if @tipo_contrato.update(tipo_contrato_params)
        format.html { redirect_to @tipo_contrato, notice: "Tipo contrato was successfully updated." }
        format.json { render :show, status: :ok, location: @tipo_contrato }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tipo_contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_contratos/1 or /tipos_contratos/1.json
  def destroy
    @tipo_contrato.destroy!

    respond_to do |format|
      format.html { redirect_to tipos_contratos_path, status: :see_other, notice: "Tipo contrato was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_contrato
      @tipo_contrato = TipoContrato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_contrato_params
      params.require(:tipo_contrato).permit(:descricao, :carga_horaria_semanal, :created_by, :updated_by, :deleted_at)
    end
end
