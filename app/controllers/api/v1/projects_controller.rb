class Api::V1::ProjectsController < Api::V1::ApplicationController
    before_action :require_logged_in
    before_action :set_project, only:[:show, :edit, :update]

    def index
        @projects = Project.all

        render json: @projects, status: :ok
    end

    def create
        @project = Project.create(project_params)

        if @project.valid?
            @project.save
            render json: @project, status: :created
        else
            render json: @project.errors, status: :unprocessable_entity
        end
    end

    def show
        # @project = Project.find_by_id_or_slug(params[:slug])
        unless @project.nil?
            render json: @project, status: :ok
        else
            render json: { error: 'Project not found.' } 
        end
    end

    def update
        @project.update(project_params)
        
        if @project.save
            render json: @project, status: :created
        else
            render json: @project.errors, status: :unprocessable_entity
        end
    end
    
    private
        def project_params
            params.require(:project).permit(:name, :description, :priority)
        end

        def set_project
            @project = Project.find_by_id_or_slug(params[:slug])
        end
end
