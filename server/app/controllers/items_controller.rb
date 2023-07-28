class ItemsController < ApplicationController
    before_action :set_container
    before_action :set_container_item, only: [:show, :update, :destroy]

    api :GET, "/containers/:container_id/items", "List all items in a container"
    param :container_id, Integer, desc: "id of the container", required: true
    def index
       render json: @container.items 
    end

    api :POST, "/containers/:container_id/items", "Create new item"
    param :container_id, Integer, desc: "id of the container", required: true
    param :name, String, desc: "Name of the new item", required: true
    param :quantity, Integer, desc: "Quantity of the new item", required: true
    def create
        item = @container.items.new(item_params)
        if item.save
            render json: item, status: :created
        else
            render json: item.errors, status: :unprocessable_entity
        end
    end

    api :GET, "/containers/:container_id/items/:id", "Show one of the items in a container"
    param :container_id, Integer, desc: "id of the container", required: true
    param :id, Integer, desc: "id of the item", required: true
    def show
        if @item
            render json: @item
        else
            render json: {message: "Item not found"}, status: :bad_request
        end
    end

    api :PATCH, "/containers/:container_id/items/:id", "Modify an item"
    param :container_id, Integer, desc: "id of the container", required: true
    param :id, Integer, desc: "id of the item", required: true
    param :name, String, desc: "New name of the item", required: false
    param :quantity, Integer, desc: "New quantity of the item", required: false
    def update
        if @item.update(item_params)
            render json: @item
        else
            render json: {message: "Item could not be updated"}, status: :unprocessable_entity
        end
    end

    api :DELETE, "/containers/:container_id/items/:id", "Delete an item from a container"
    param :container_id, Integer, desc: "id of the container", required: true
    param :id, Integer, desc: "id of the item", required: true
    def destroy
        @item.destroy
        head :no_content
    end

    private

    def item_params
        params.require(:item).permit(:name, :quantity)
    end

    def set_container
        @container = Container.find(params[:container_id])
    end

    def set_container_item
        @item = @container.items.find_by(id: params[:id]) if @container
    end
end
