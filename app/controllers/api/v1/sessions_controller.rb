class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :set_action_user, :authenticate_user_from_token!, only: [:create, :connect]
  skip_before_action :authenticate_app_from_token!, only: [:destroy, :connect]
  skip_after_action :update_session

  def create
    user = User.find_by(email: params[:user][:email])
    # render json: @user.errors, status: :unprocessable_entity unless @user && @user.authenticate(params[:user][:password])
    
    if user && user.authenticate(params[:user][:password])
      # session[:user_id] = @user.id
      sessionn = user.get_session(@app)
      render json: sessionn, status: :created
    else
        render json: user.errors, status: :unprocessable_entity
    end
  end

  def connect
    App.find_each do |app|
      if Devise.secure_compare(app.key, params['client_id']) && Devise.secure_compare(app.secret, params['client_secret'])
        # Devise.secure_compare(app.key, @header['HTTP_CLIENT_ID']) && Devise.secure_compare(app.secret, @header['HTTP_CLIENT_SECRET'])
        app.set_wired
        # @app = app
        render json: {status: 200}, status: :ok and return
      end
    end
    render json: {meta: {status: 424, errors: "can't authenticate application with given client_id and client_secret"}}, status: :failed_dependency and return
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
