# frozen_string_literal: true
class TiposContratosController < ApplicationController
  before_action :set_tipo_contrato, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = TipoContrato.ransack(params[:q])
    @pagy, @tipos_contratos = pagy(@q.result)
  end

  def new
    @tipo_contrato = TipoContrato.new
  end

  def edit
  end

  def create
    @tipo_contrato = TipoContrato.new(tipo_contrato_params)

    if @tipo_contrato.save
      redirect_to tipos_contratos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tipo_contrato.update(tipo_contrato_params)
      redirect_to tipos_contratos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @tipo_contrato.destroy
      redirect_to tipos_contratos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to tipos_contratos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_tipo_contrato
    @tipo_contrato = TipoContrato.find_by(id: params[:id])
    return redirect_to tipos_contratos_path, alert: t('messages.not_found') unless @tipo_contrato
  end

  def tipo_contrato_params
    permitted_attributes = TipoContrato.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:tipo_contrato).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to tipos_contratos_path, alert: t('messages.not_found')
  end
end
