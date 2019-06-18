class Api::V1::ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    before_action :parse_request, :authenticate_app_from_token!, :authenticate_user_from_token!
    before_action :set_action_user, only: [:create, :update]
    after_action :update_session

    def current_user_s
      user = (@session.user || User.new)
    end

    def current_app
      app = ((@session.app || @app) || App.new)
    end

    def logged_in?
      current_user_s.id != nil
    end

    def require_logged_in
      render json: {meta: {status: 401, errors: "unauthorized access"}}, status: :unauthorized unless logged_in?
    end

    def set_action_user
      current_app.set_current_app
      current_user_s.set_current_user
    end

    def update_session
      @session.update(activity: "")
    end

    private
      def authenticate_app_from_token!
        # @json = @json['body']
        if @header['HTTP_GRANT_TYPE']
          if @header['HTTP_GRANT_TYPE']!='client_credentials'# && !params['client_id'] && !params['client_secret']#!@header['HTTP_CLIENT_ID'] && !@header['HTTP_CLIENT_SECRET']
            render json: {meta: {status: 401, errors: "unauthorized access"}}, status: :unauthorized#render nothing: true, status: :unauthorized
          end          
        else
          if !@header['HTTP_CLIENT_ID']# && !@header['HTTP_CLIENT_SECRET']
            render json: {meta: {status: 401, errors: "unauthorized access"}}, status: :unauthorized
          else
            App.find_each do |app|
              if Devise.secure_compare(app.key, @header['HTTP_CLIENT_ID']) && app.wired?
                # Devise.secure_compare(app.key, @header['HTTP_CLIENT_ID']) && Devise.secure_compare(app.secret, @header['HTTP_CLIENT_SECRET'])
                @app = app   
              end
            end
          end
        end
      end

      def authenticate_user_from_token!
        # @json = @json['headers']
        if !@header['HTTP_TOKEN']
          render json: {meta: {status: 401, errors: "unauthorized access"}}, status: :unauthorized
        else
          # puts Session.all.inspect
          Session.all.each do |sess|
            if Devise.secure_compare(sess.api_token, @header['HTTP_TOKEN'])
              @session = sess  
            end
          end
        end
      end

      def parse_request
        # @json = JSON.parse(params.to_json) # JSON.parse(request.body.read)
        @header = request.headers
      end
end
