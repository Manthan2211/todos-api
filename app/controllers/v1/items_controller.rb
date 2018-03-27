module V1
  class ItemsController < ApplicationController
    before_action :set_todo
    before_action :set_todo_item, only: [:show, :update, :destroy]

    def_param_group :ids do
      param :todo_id, Integer, desc: "todo_id", required: true
      param :id, Integer, desc: "item_id", required: true
    end

    def_param_group :item do 
      param :name, String, desc: "name of items", required: true
      param :done, [true, false],desc: "Item done or not", required: true
    end
  
    api :GET,'/todos/:todo_id/items',"list of all items For given todo_id"
    param :todo_id, Integer, desc: "todo_id", required: true
    def index
      json_response(@todo.items)
    end

    api :GET,'/todos/:todo_id/items/:id', "List of specific item"
    param_group :ids
    def show
      json_response(@item)
    end

    api :POST,'/todos/:todo_id/items',"Create Item"
    param :todo_id, Integer, desc: "todo_id", required: true
    param_group :item
    def create
      @todo.items.create!(item_params)
      json_response(@todo, :created)
    end

    api :PUT,'/todos/:todo_id/items/:id',"Update Item"
    param_group :ids
    param_group :item
    def update
      @item.update(item_params)
      head :no_content
    end

    api :DELETE,'/todos/:todo_id/items/:id',"Delete Item"
    param_group :ids
    def destroy
      @item.destroy
      head :no_content
    end

    private

    def item_params
      params.permit(:name, :done)
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_todo_item
      @item = @todo.items.find_by!(id: params[:id]) if @todo
    end
  end
end