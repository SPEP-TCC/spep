# frozen_string_literal: true
class RestricoesController < ApplicationController
  before_action :set_restricao, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Restricao.ransack(params[:q])
    @pagy, @restricoes = pagy(@q.result)
  end

  def new
    @restricao = Restricao.new
  end

  def edit
  end

  def create
    @restricao = Restricao.new(restricao_params)

    if @restricao.save
      redirect_to restricoes_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @restricao.update(restricao_params)
      redirect_to restricoes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @restricao.destroy
      redirect_to restricoes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to restricoes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_restricao
    @restricao = Restricao.find_by(id: params[:id])
    return redirect_to restricoes_path, alert: t('messages.not_found') unless @restricao
  end

  def restricao_params
    permitted_attributes = Restricao.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:restricao).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to restricoes_path, alert: t('messages.not_found')
  end
end
