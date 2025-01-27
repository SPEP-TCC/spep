# frozen_string_literal: true
class DisponibilidadeSalasController < ApplicationController
  before_action :set_disponibilidade_sala, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = DisponibilidadeSala.ransack(params[:q])
    @pagy, @disponibilidade_salas = pagy(@q.result)
  end

  def new
    @disponibilidade_sala = DisponibilidadeSala.new
  end

  def edit
  end

  def create
    @disponibilidade_sala = DisponibilidadeSala.new(disponibilidade_sala_params)

    if @disponibilidade_sala.save
      redirect_to disponibilidade_salas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @disponibilidade_sala.update(disponibilidade_sala_params)
      redirect_to disponibilidade_salas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @disponibilidade_sala.destroy
      redirect_to disponibilidade_salas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to disponibilidade_salas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_disponibilidade_sala
    @disponibilidade_sala = DisponibilidadeSala.find_by(id: params[:id])
    return redirect_to disponibilidade_salas_path, alert: t('messages.not_found') unless @disponibilidade_sala
  end

  def disponibilidade_sala_params
    permitted_attributes = DisponibilidadeSala.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:disponibilidade_sala).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to disponibilidade_salas_path, alert: t('messages.not_found')
  end
end
