# frozen_string_literal: true
class CursosController < ApplicationController
  before_action :set_curso, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Curso.ransack(params[:q])
    @pagy, @cursos = pagy(@q.result)
  end

  def new
    @curso = Curso.new
  end

  def edit
  end

  def create
    @curso = Curso.new(curso_params)

    if @curso.save
      redirect_to cursos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @curso.update(curso_params)
      redirect_to cursos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @curso.destroy
      redirect_to cursos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to cursos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_curso
    @curso = Curso.find_by(id: params[:id])
    return redirect_to cursos_path, alert: t('messages.not_found') unless @curso
  end

  def curso_params
    permitted_attributes = Curso.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:curso).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to cursos_path, alert: t('messages.not_found')
  end
end
