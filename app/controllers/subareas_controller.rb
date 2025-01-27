# frozen_string_literal: true
class SubareasController < ApplicationController
  before_action :set_subarea, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Subarea.ransack(params[:q])
    @pagy, @subareas = pagy(@q.result)
  end

  def new
    @subarea = Subarea.new
  end

  def edit
  end

  def create
    @subarea = Subarea.new(subarea_params)

    if @subarea.save
      redirect_to subareas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @subarea.update(subarea_params)
      redirect_to subareas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @subarea.destroy
      redirect_to subareas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to subareas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_subarea
    @subarea = Subarea.find_by(id: params[:id])
    return redirect_to subareas_path, alert: t('messages.not_found') unless @subarea
  end

  def subarea_params
    permitted_attributes = Subarea.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:subarea).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to subareas_path, alert: t('messages.not_found')
  end
end
