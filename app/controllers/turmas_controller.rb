# frozen_string_literal: true

class TurmasController < ApplicationController
  before_action :set_turma, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Turma.ransack(params[:q])
    @pagy, @turmas = pagy(@q.result)
  end

  def new
    @turma = Turma.new
    @turma.grades_curriculares_turmas.new
  end

  def edit
    @user.grades_curriculares_turmas.build
  end

  def create
    @turma = Turma.new(turma_params)

    if @turma.save
      redirect_to turmas_path, notice: t("messages.created_successfully")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @turma.update(turma_params)
      redirect_to turmas_path, notice: t("messages.updated_successfully"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @turma.destroy
      redirect_to turmas_url, notice: t("messages.deleted_successfully")
    else
      redirect_to turmas_url, alert: t("messages.delete_failed_due_to_dependencies")
    end
  end

  private

  def set_turma
    @turma = Turma.find_by(id: params[:id])
    redirect_to turmas_path, alert: t("messages.not_found") unless @turma
  end

  def turma_params
    permitted_attributes = Turma.column_names.reject { |col| [ "deleted_at", "created_by", "updated_by" ].include?(col) }
    params.require(:turma).permit(permitted_attributes.map(&:to_sym),
                                  grades_curriculares_turmas_attributes: [ :grade_curricular_id, :_destroy ])
  end

  def handle_not_found
    redirect_to turmas_path, alert: t("messages.not_found")
  end
end
