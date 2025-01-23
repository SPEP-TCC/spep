# frozen_string_literal: true
class DisciplinasController < ApplicationController
  before_action :set_disciplina, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Disciplina.ransack(params[:q])
    @pagy, @disciplinas = pagy(@q.result)
  end

  def new
    @disciplina = Disciplina.new
  end

  def edit
  end

  def create
    @disciplina = Disciplina.new(disciplina_params)

    if @disciplina.save
      redirect_to disciplinas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @disciplina.update(disciplina_params)
      redirect_to disciplinas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @disciplina.destroy
      redirect_to disciplinas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to disciplinas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_disciplina
    @disciplina = Disciplina.find_by(id: params[:id])
    return redirect_to disciplinas_path, alert: t('messages.not_found') unless @disciplina
  end

  def disciplina_params
    permitted_attributes = Disciplina.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:disciplina).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to disciplinas_path, alert: t('messages.not_found')
  end
end
