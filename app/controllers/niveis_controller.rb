class NiveisController < ApplicationController
  before_action :set_nivel, only: %i[ show edit update destroy ]

  # GET /niveis or /niveis.json
  def index
    @niveis = Nivel.all
  end

  # GET /niveis/1 or /niveis/1.json
  def show
  end

  # GET /niveis/new
  def new
    @nivel = Nivel.new
  end

  # GET /niveis/1/edit
  def edit
  end

  # POST /niveis or /niveis.json
  def create
    @nivel = Nivel.new(nivel_params)

    respond_to do |format|
      if @nivel.save
        format.html { redirect_to @nivel, notice: "Nivel was successfully created." }
        format.json { render :show, status: :created, location: @nivel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nivel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /niveis/1 or /niveis/1.json
  def update
    respond_to do |format|
      if @nivel.update(nivel_params)
        format.html { redirect_to @nivel, notice: "Nivel was successfully updated." }
        format.json { render :show, status: :ok, location: @nivel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nivel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /niveis/1 or /niveis/1.json
  def destroy
    @nivel.destroy!

    respond_to do |format|
      format.html { redirect_to niveis_path, status: :see_other, notice: "Nivel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nivel
      @nivel = Nivel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nivel_params
      params.require(:nivel).permit(:descricao, :created_by, :updated_by, :deleted_at)
    end
end
