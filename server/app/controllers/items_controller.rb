class ItemsController < ApplicationController
    before_action :set_container
    before_action :set_container_item, only: [:show, :update, :destroy]

    # GET /containers/:container_id/items
    def index
       render json: ItemSerializer.new(@container.items)
    end

    # POST /containers/:container_id/items
    def create
        item = @container.items.new(item_params)
        if item.save
            render json: ItemSerializer.new(item), status: :created
        else
            render json: { error: "Item creation failed" }, status: :unprocessable_entity
        end
    end

    # GET /containers/:container_id/items/:id
    def show
        if @item
            render json: ItemSerializer.new(@item)
        else
            render json: { error: "Item not found" }, status: :not_found
        end
    end

    # PATCH /containers/:container_id/items/:id
    def update
        if @item.update(item_params)
            render json: ItemSerializer.new(@item), status: :ok
        else
            render json: { error: "Item update failed" }, status: :unprocessable_entity
        end
    end

    # DELETE /containers/:container_id/items/:id
    def destroy
        if @item.destroy
            render json: { message: "Item successfully deleted" }, status: :ok
        else
            render json: { error: "Item deletion failed" }, status: :internal_server_error
        end
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
