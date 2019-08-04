class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を変更しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報の変更に失敗しました。'
      render :edit
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :profimg)
  end
end