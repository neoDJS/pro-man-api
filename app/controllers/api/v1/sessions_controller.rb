class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :set_action_user, :authenticate_user_from_token!, only: [:create]
  skip_before_action :authenticate_app_from_token!, only: [:destroy]
  skip_after_action :update_session

  def create
    user = User.find_by(email: params[:user][:email])
    # render json: @user.errors, status: :unprocessable_entity unless @user && @user.authenticate(params[:user][:password])
    
    if user && user.authenticate(params[:user][:password])
      # session[:user_id] = @user.id
      sessionn = user.get_session(@app)
      render json: sessionn, status: :created
    else
        render json: user.errors, stjatus: :unprocessable_entity
    end
  end

  def destroy
    @session.delete
    # redirect_to '/'
  end

  private

    # def auth
    #   request.env['omniauth.auth']
    # end
end
