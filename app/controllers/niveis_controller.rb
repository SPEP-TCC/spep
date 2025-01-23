# frozen_string_literal: true
class NiveisController < ApplicationController
  before_action :set_nivel, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Nivel.ransack(params[:q])
    @pagy, @niveis = pagy(@q.result)
  end

  def new
    @nivel = Nivel.new
  end

  def edit
  end

  def create
    @nivel = Nivel.new(nivel_params)

    if @nivel.save
      redirect_to niveis_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @nivel.update(nivel_params)
      redirect_to niveis_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @nivel.destroy
      redirect_to niveis_url, notice: t('messages.deleted_successfully')
    else
      redirect_to niveis_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_nivel
    @nivel = Nivel.find_by(id: params[:id])
    return redirect_to niveis_path, alert: t('messages.not_found') unless @nivel
  end

  def nivel_params
    permitted_attributes = Nivel.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:nivel).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to niveis_path, alert: t('messages.not_found')
  end
end
