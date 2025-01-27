# frozen_string_literal: true
class MetodologiasController < ApplicationController
  before_action :set_metodologia, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Metodologia.ransack(params[:q])
    @pagy, @metodologias = pagy(@q.result)
  end

  def new
    @metodologia = Metodologia.new
  end

  def edit
  end

  def create
    @metodologia = Metodologia.new(metodologia_params)

    if @metodologia.save
      redirect_to metodologias_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @metodologia.update(metodologia_params)
      redirect_to metodologias_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @metodologia.destroy
      redirect_to metodologias_url, notice: t('messages.deleted_successfully')
    else
      redirect_to metodologias_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_metodologia
    @metodologia = Metodologia.find_by(id: params[:id])
    return redirect_to metodologias_path, alert: t('messages.not_found') unless @metodologia
  end

  def metodologia_params
    permitted_attributes = Metodologia.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:metodologia).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to metodologias_path, alert: t('messages.not_found')
  end
end
