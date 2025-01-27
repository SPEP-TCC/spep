# frozen_string_literal: true
class GradesCurricularesController < ApplicationController
  before_action :set_grade_curricular, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GradeCurricular.ransack(params[:q])
    @pagy, @grades_curriculares = pagy(@q.result)
  end

  def new
    @grade_curricular = GradeCurricular.new
  end

  def edit
  end

  def create
    @grade_curricular = GradeCurricular.new(grade_curricular_params)

    if @grade_curricular.save
      redirect_to grades_curriculares_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @grade_curricular.update(grade_curricular_params)
      redirect_to grades_curriculares_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @grade_curricular.destroy
      redirect_to grades_curriculares_url, notice: t('messages.deleted_successfully')
    else
      redirect_to grades_curriculares_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_grade_curricular
    @grade_curricular = GradeCurricular.find_by(id: params[:id])
    return redirect_to grades_curriculares_path, alert: t('messages.not_found') unless @grade_curricular
  end

  def grade_curricular_params
    permitted_attributes = GradeCurricular.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:grade_curricular).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to grades_curriculares_path, alert: t('messages.not_found')
  end
end
