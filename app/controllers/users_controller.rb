class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :followings, :followers, :favposts]
  before_action :correct_user_edit, only: [:edit, :update]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).search(params[:search])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
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
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page])
    counts(@user)
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :profimg)
  end
  
  def correct_user_edit
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_back(fallback_location: root_path)
    end
  end
  
end
