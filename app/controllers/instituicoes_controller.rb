# frozen_string_literal: true
class InstituicoesController < ApplicationController
  before_action :set_instituicao, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Instituicao.ransack(params[:q])
    @pagy, @instituicoes = pagy(@q.result)
  end

  def new
    @instituicao = Instituicao.new
  end

  def edit
  end

  def create
    @instituicao = Instituicao.new(instituicao_params)

    if @instituicao.save
      redirect_to instituicoes_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @instituicao.update(instituicao_params)
      redirect_to instituicoes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @instituicao.destroy
      redirect_to instituicoes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to instituicoes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_instituicao
    @instituicao = Instituicao.find_by(id: params[:id])
    return redirect_to instituicoes_path, alert: t('messages.not_found') unless @instituicao
  end

  def instituicao_params
    permitted_attributes = Instituicao.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:instituicao).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to instituicoes_path, alert: t('messages.not_found')
  end
end
