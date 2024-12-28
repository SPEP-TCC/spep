class MetodologiasController < ApplicationController
  before_action :set_metodologia, only: %i[ show edit update destroy ]

  # GET /metodologias or /metodologias.json
  def index
    @metodologias = Metodologia.all
  end

  # GET /metodologias/1 or /metodologias/1.json
  def show
  end

  # GET /metodologias/new
  def new
    @metodologia = Metodologia.new
  end

  # GET /metodologias/1/edit
  def edit
  end

  # POST /metodologias or /metodologias.json
  def create
    @metodologia = Metodologia.new(metodologia_params)

    respond_to do |format|
      if @metodologia.save
        format.html { redirect_to @metodologia, notice: "Metodologia was successfully created." }
        format.json { render :show, status: :created, location: @metodologia }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @metodologia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metodologias/1 or /metodologias/1.json
  def update
    respond_to do |format|
      if @metodologia.update(metodologia_params)
        format.html { redirect_to @metodologia, notice: "Metodologia was successfully updated." }
        format.json { render :show, status: :ok, location: @metodologia }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @metodologia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metodologias/1 or /metodologias/1.json
  def destroy
    @metodologia.destroy!

    respond_to do |format|
      format.html { redirect_to metodologias_path, status: :see_other, notice: "Metodologia was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metodologia
      @metodologia = Metodologia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def metodologia_params
      params.require(:metodologia).permit(:descricao, :created_by, :updated_by, :deleted_at)
    end
end
