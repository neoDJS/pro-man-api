# class AppsController < ApplicationController
#     before_action :require_logged_in
#     before_action :set_user
#     before_action :set_app, only:[:show]
#     before_action :set_action_user, only: [:create]

#     def index
#         @apps = @user.apps
    
#         respond_to do |format|
#             if @apps.empty?
#                 format.html { redirect_to user_path(@user), alert: 'Apps is empty.' }                
#             else
#                 format.html { render :index }
#             end
#             format.json { render json: @apps, status: :ok }
#         end
#     end
      
#     def new
#     end

#     def create
#       @app = App.create(app_params)
  
#       respond_to do |format|
#         if @app.valid?
#             @app.save
#             format.html { redirect_to user_app_path(@user, @app), notice: 'App was successfully created.' }
#             format.json { render :show, status: :created, location: @app }                
#         else
#             format.html { render :new }
#             format.json { render json: @app.errors, status: :unprocessable_entity }
#         end
#       end
#     end

#     def show
#       respond_to do |format|
#           unless @app.nil?
#               format.html { render :show }         
#           else
#               format.html { redirect_to user_app_path(@user, @app), alert: 'App not found.' }
#           end
#           format.json { render json: @app, status: :ok }
#       end  
#     end
    
#     private
#         def app_params
#             params.require(:app).permit(:name)
#         end

#         def set_user
#             @user = User.find(params[:user_id])
#         end

#         def set_registered_app
#             @app = App.find_by(user_id: @user.id, id: (params[:id]))
#         end
# end
