# frozen_string_literal: true
class CurriculosEmentasController < ApplicationController
  before_action :set_curriculo_ementa, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = CurriculoEmenta.ransack(params[:q])
    @pagy, @curriculos_ementas = pagy(@q.result)
  end

  def new
    @curriculo_ementa = CurriculoEmenta.new
  end

  def edit
  end

  def create
    @curriculo_ementa = CurriculoEmenta.new(curriculo_ementa_params)

    if @curriculo_ementa.save
      redirect_to curriculos_ementas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @curriculo_ementa.update(curriculo_ementa_params)
      redirect_to curriculos_ementas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @curriculo_ementa.destroy
      redirect_to curriculos_ementas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to curriculos_ementas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_curriculo_ementa
    @curriculo_ementa = CurriculoEmenta.find_by(id: params[:id])
    return redirect_to curriculos_ementas_path, alert: t('messages.not_found') unless @curriculo_ementa
  end

  def curriculo_ementa_params
    permitted_attributes = CurriculoEmenta.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:curriculo_ementa).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to curriculos_ementas_path, alert: t('messages.not_found')
  end
end
