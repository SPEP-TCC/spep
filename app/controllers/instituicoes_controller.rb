class InstituicoesController < ApplicationController
  before_action :set_instituicao, only: %i[ show edit update destroy ]

  # GET /instituicoes or /instituicoes.json
  def index
    @instituicoes = Instituicao.all
  end

  # GET /instituicoes/1 or /instituicoes/1.json
  def show
  end

  # GET /instituicoes/new
  def new
    @instituicao = Instituicao.new
  end

  # GET /instituicoes/1/edit
  def edit
  end

  # POST /instituicoes or /instituicoes.json
  def create
    @instituicao = Instituicao.new(instituicao_params)

    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to @instituicao, notice: "Instituicao was successfully created." }
        format.json { render :show, status: :created, location: @instituicao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @instituicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instituicoes/1 or /instituicoes/1.json
  def update
    respond_to do |format|
      if @instituicao.update(instituicao_params)
        format.html { redirect_to @instituicao, notice: "Instituicao was successfully updated." }
        format.json { render :show, status: :ok, location: @instituicao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instituicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instituicoes/1 or /instituicoes/1.json
  def destroy
    @instituicao.destroy!

    respond_to do |format|
      format.html { redirect_to instituicoes_path, status: :see_other, notice: "Instituicao was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instituicao
      @instituicao = Instituicao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instituicao_params
      params.require(:instituicao).permit(:nome, :duracao_aula, :tempos_aula, :cnpj, :inep, :endereco, :created_by, :updated_by, :deleted_at)
    end
end
