class Api::V1::WorkersController < Api::V1::ApplicationController
    skip_before_action :authenticate_app_from_token!
    before_action :require_logged_in
    before_action :set_worker, only:[:show, :edit, :update]

    def index
      @workers = Worker.all
  
      render json: @workers, status: :ok
    end
  
    def show
        unless @worker.nil?
            render json: @worker, status: :ok      
        else
            render json: { error: 'Worker not found.' }   
        end
    end
  
    def create
        @worker = Worker.create(worker_params)
        if @worker.valid?
            @worker.save
            render json: @worker, status: :created
        else
            render json: @worker.errors, status: :unprocessable_entity
        end
    end
  
    def update
      @worker.update(worker_params)
      
      
        if @worker.save
            render json: @worker, status: :created
        else
            render json: @worker.errors, status: :unprocessable_entity
        end
    end
  
    private
  
        def worker_params
            params.require(:worker).permit(:title, user_attributes: [:name, :password, :email])
        end

        def set_worker
            @worker = Worker.find(params[:id])
        end
end
