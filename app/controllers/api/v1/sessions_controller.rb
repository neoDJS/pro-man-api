class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :set_action_user

  def create
    if auth
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        sha256 = Digest::SHA2.new(256)
        u.password = sha256.hexdigest(u.name)
        # u.image = auth['info']['image']
      end
    else
      @user = User.find_by(name: params[:user][:name])
      render json: @user.errors, status: :unprocessable_entity unless @user.authenticate(params[:user][:password])
    end

    if @user
      # @user.set_current_user
      session[:user_id] = @user.id
      render json: @user, status: :created
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private

    def auth
      request.env['omniauth.auth']
    end
end
