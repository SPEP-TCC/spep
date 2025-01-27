# frozen_string_literal: true
class TurnosController < ApplicationController
  before_action :set_turno, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Turno.ransack(params[:q])
    @pagy, @turnos = pagy(@q.result)
  end

  def new
    @turno = Turno.new
  end

  def edit
  end

  def create
    @turno = Turno.new(turno_params)

    if @turno.save
      redirect_to turnos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @turno.update(turno_params)
      redirect_to turnos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @turno.destroy
      redirect_to turnos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to turnos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_turno
    @turno = Turno.find_by(id: params[:id])
    return redirect_to turnos_path, alert: t('messages.not_found') unless @turno
  end

  def turno_params
    permitted_attributes = Turno.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:turno).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to turnos_path, alert: t('messages.not_found')
  end
end
