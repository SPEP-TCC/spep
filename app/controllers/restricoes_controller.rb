class RestricoesController < ApplicationController
  before_action :set_restricao, only: %i[ show edit update destroy ]

  # GET /restricoes or /restricoes.json
  def index
    @restricoes = Restricao.all
  end

  # GET /restricoes/1 or /restricoes/1.json
  def show
  end

  # GET /restricoes/new
  def new
    @restricao = Restricao.new
  end

  # GET /restricoes/1/edit
  def edit
  end

  # POST /restricoes or /restricoes.json
  def create
    @restricao = Restricao.new(restricao_params)

    respond_to do |format|
      if @restricao.save
        format.html { redirect_to @restricao, notice: "Restricao was successfully created." }
        format.json { render :show, status: :created, location: @restricao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restricao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restricoes/1 or /restricoes/1.json
  def update
    respond_to do |format|
      if @restricao.update(restricao_params)
        format.html { redirect_to @restricao, notice: "Restricao was successfully updated." }
        format.json { render :show, status: :ok, location: @restricao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restricao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restricoes/1 or /restricoes/1.json
  def destroy
    @restricao.destroy!

    respond_to do |format|
      format.html { redirect_to restricoes_path, status: :see_other, notice: "Restricao was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restricao
      @restricao = Restricao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restricao_params
      params.require(:restricao).permit(:user_id, :turno_id, :dia, :horario, :created_by, :updated_by, :deleted_at)
    end
end
