class Api::V1::ApplicationController < ActionController::API
    protect_from_forgery with: :exception
    before_filter :parse_request, :authenticate_app_from_token!
    before_action :current_user
    before_action :set_action_user, only: [:create, :update]
    helper_method :logged_in?

    def current_user
        @user = (User.find_by(id: session[:user_id]) || User.new)
    end

    def logged_in?
        current_user.id != nil
    end

    def require_logged_in
        return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
    end

    def set_action_user
        current_user.set_current_user
    end

    private
       def authenticate_app_from_token!
         if !@json['api_token']
           render nothing: true, status: :unauthorized
         else
           @app = nil
           App.find_each do |app|
             if Devise.secure_compare(app.api_token, @json['api_token'])
               @app = app
             end
           end
         end
       end

       def parse_request
         @json = JSON.parse(request.body.read)
       end
end
