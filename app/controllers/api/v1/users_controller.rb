class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :require_logged_in, only:[:show, :edit, :update]
  skip_before_action :authenticate_app_from_token!, only: [:index, :show, :update]
  skip_before_action :set_action_user, :authenticate_user_from_token!, only: [:create]

  def index
    @users = User.all

    render json: @users, status: :ok 
  end

  def show    
    @user = User.find(params[:id])
        unless @user.nil?
          render json: @user, status: :ok
        else
          render json: { error: 'User not found.' } 
        end
  end

  def create
    @user = User.create(user_params)
    # return redirect_to controller: 'users', action: 'new' unless @user.save
    
    if @user.valid?
        @user.save
        # @user.set_current_user
        session[:user_id] = @user.id
        render json: @user, status: :created
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update    
    @user = User.find(params[:id])
    @user.update(user_params)

    
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity 
      end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
end
