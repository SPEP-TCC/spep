# frozen_string_literal: true
class AreasController < ApplicationController
  before_action :set_area, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Area.ransack(params[:q])
    @pagy, @areas = pagy(@q.result)
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new(area_params)

    if @area.save
      redirect_to areas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @area.update(area_params)
      redirect_to areas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @area.destroy
      redirect_to areas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to areas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_area
    @area = Area.find_by(id: params[:id])
    return redirect_to areas_path, alert: t('messages.not_found') unless @area
  end

  def area_params
    permitted_attributes = Area.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:area).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to areas_path, alert: t('messages.not_found')
  end
end
