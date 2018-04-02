module V1
  class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
    before_action :authorize_request
    set_pagination_headers :todos, only: [:index]

    api :GET , '/todos', 'List of all todos'
    def index
      @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
      json_response(@todos)
    end

    
    api :POST , '/todos', 'Create Todo'
    param :title, String,desc: "Title of Todo", required: true
    def create
      @todo = current_user.todos.create!(todo_params)
      json_response(@todo, :created)
    end

    # GET /todos/:id
    api :GET , '/todos/:id', 'Show Details of todo'
    param :id, Integer, desc: "todo_id", required: true
    def show
      json_response(@todo)
    end

    # PUT /todos/:id
    api :PUT , '/todos/:id', 'Update Todo'
    param :title, String,desc: "Title of Todo", required: true
    def update
      @todo.update(todo_params)
      head :no_content
    end

    # DELETE /todos/:id
    api :DELETE , '/todos/:id', 'Delete Todo'
    param :id, String, desc: "todo_id", required: true
    def destroy
      @todo.destroy
      head :no_content
    end

    private

    def todo_params
      # whitelist params
      params.permit(:title, :created_by)
    end

    def set_todo
      @todo = Todo.find(params[:id])
    end
  end
end