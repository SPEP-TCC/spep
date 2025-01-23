# frozen_string_literal: true
class AmbientesController < ApplicationController
  before_action :set_ambiente, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Ambiente.ransack(params[:q])
    @pagy, @ambientes = pagy(@q.result)
  end

  def new
    @ambiente = Ambiente.new
  end

  def edit
  end

  def create
    @ambiente = Ambiente.new(ambiente_params)

    if @ambiente.save
      redirect_to ambientes_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ambiente.update(ambiente_params)
      redirect_to ambientes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @ambiente.destroy
      redirect_to ambientes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to ambientes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_ambiente
    @ambiente = Ambiente.find_by(id: params[:id])
    return redirect_to ambientes_path, alert: t('messages.not_found') unless @ambiente
  end

  def ambiente_params
    permitted_attributes = Ambiente.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:ambiente).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to ambientes_path, alert: t('messages.not_found')
  end
end
