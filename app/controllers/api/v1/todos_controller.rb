class Api::V1::TodosController < Api::V1::ApplicationController
    before_action :require_logged_in
    before_action :set_project
    before_action :set_todo, only:[:show, :edit, :update, :addWorker, :affectation]
    before_action :set_action_user, only: [:create, :update, :affectation]


    def addWorker
        selected = @todo.workers
        @workers = Worker.all - selected

        render json: {todo: @todo, workers: @workers}, status: :ok }
    end

    def affectation
        puts "affect todo"
        puts todo_workers_params.inspect
        if todo_workers_params
            @todo.affected_to(todo_workers_params)
        end

        render json: @todo, status: :ok
    end

    def create
        @todo = @project.todos.new(todo_params)
        
        if @todo.valid?
            @todo.save
            render json: @todo, status: :created
        else
            render json: @todo.errors, status: :unprocessable_entity
        end
    end

    def index
        @todos = @project.todos #Todo.all_by_project_slug(params[:project_slug])

        render json: @todos, status: :ok
    end

    def show
        unless @todo.nil?
            render json: @todo, status: :ok
        else
            render json: { error: 'Todo not found.' }
        end
    end

    def update
        @todo.update(todo_params)
        if @todo.save
            render json: @todo, status: :created
        else
            render json: @todo.errors, status: :unprocessable_entity
        end
    end
    
    private
        def todo_params
            params.require(:todo).permit(:task)
        end

        def todo_workers_params
            params.permit(worker_ids:[])
        end

        def set_project
            puts params.inspect
            @project = Project.find_by_id_or_slug(params[:project_slug])
        end

        def set_todo
            # project = Project.find_by_id_or_slug(params[:project_slug])
            @todo = Todo.find_by(project_id: @project.id, id: (params[:todo_id]||params[:id]))
        end
end
