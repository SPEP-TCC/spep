# frozen_string_literal: true
class CurriculoEmentaDisciplinasController < ApplicationController
  before_action :set_curriculo_ementa_disciplina, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = CurriculoEmentaDisciplina.ransack(params[:q])
    @pagy, @curriculo_ementa_disciplinas = pagy(@q.result)
  end

  def new
    @curriculo_ementa_disciplina = CurriculoEmentaDisciplina.new
  end

  def edit
  end

  def create
    @curriculo_ementa_disciplina = CurriculoEmentaDisciplina.new(curriculo_ementa_disciplina_params)

    if @curriculo_ementa_disciplina.save
      redirect_to curriculo_ementa_disciplinas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @curriculo_ementa_disciplina.update(curriculo_ementa_disciplina_params)
      redirect_to curriculo_ementa_disciplinas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @curriculo_ementa_disciplina.destroy
      redirect_to curriculo_ementa_disciplinas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to curriculo_ementa_disciplinas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_curriculo_ementa_disciplina
    @curriculo_ementa_disciplina = CurriculoEmentaDisciplina.find_by(id: params[:id])
    return redirect_to curriculo_ementa_disciplinas_path, alert: t('messages.not_found') unless @curriculo_ementa_disciplina
  end

  def curriculo_ementa_disciplina_params
    permitted_attributes = CurriculoEmentaDisciplina.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:curriculo_ementa_disciplina).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to curriculo_ementa_disciplinas_path, alert: t('messages.not_found')
  end
end
