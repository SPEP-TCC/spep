# frozen_string_literal: true
class EtapasController < ApplicationController
  before_action :set_etapa, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Etapa.ransack(params[:q])
    @pagy, @etapas = pagy(@q.result)
  end

  def new
    @etapa = Etapa.new
  end

  def edit
  end

  def create
    @etapa = Etapa.new(etapa_params)

    if @etapa.save
      redirect_to etapas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @etapa.update(etapa_params)
      redirect_to etapas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @etapa.destroy
      redirect_to etapas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to etapas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_etapa
    @etapa = Etapa.find_by(id: params[:id])
    return redirect_to etapas_path, alert: t('messages.not_found') unless @etapa
  end

  def etapa_params
    permitted_attributes = Etapa.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:etapa).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to etapas_path, alert: t('messages.not_found')
  end
end
