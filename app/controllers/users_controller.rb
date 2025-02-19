class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  #  before_action :verify_admin, only: %i[index new create destroy]
  #  before_action :verify_access, only: %i[edit update]

  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result)
  end

  def new
    @user = User.new
    @user.restricoes.new
  end

  def edit
    @user.restricoes.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Registro cadastrado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "Registro atualizado com sucesso!", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: "Registro foi marcado como excluído."
    else
      redirect_to users_path, alert: "Ainda existem dependentes desse registro."
    end
  end

  private

  def verify_admin
    redirect_to(root_path, alert: I18n.t("errors.not_authorized")) unless current_user.admin?
  end

  def verify_access
    return if current_user.admin? || current_user == @user
    redirect_to root_path, alert: I18n.t("errors.not_authorized")
  end

  def set_user
    @user = User.find_by_id(params[:id])
    redirect_to(root_path, alert: I18n.t("errors.user_not_found")) unless @user
    @user.updated_by = current_user.cpf
  end

  def user_params
    params.require(:user).permit(
      :email,
      :cpf,
      :admin,
      :nome,
      :tipo_contrato_id,
      :password,
      :password_confirmation,
      restricoes_attributes: [ :id, :dia, :horario, :turno_id, :_destroy ]
    )
  end
end
