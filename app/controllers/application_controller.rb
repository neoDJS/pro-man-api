class ApplicationController < ActionController::API
    before_filter :parse_request, :authenticate_app_from_token!

    
    def current_user
        User.find(session[:user_id]) if logged_in?
    end

    def logged_in?
        !!session[:user_id]
    end

    private
       def authenticate_app_from_token!
         if !@json['api_token']
           render nothing: true, status: :unauthorized
         else
           @app = nil
           RegisteredApp.find_each do |app|
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
