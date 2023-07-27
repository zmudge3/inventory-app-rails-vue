class ItemsController < ApplicationController
    before_action :set_container
    before_action :set_container_item, only: [:show, :update, :destroy]

    # GET /containers/:id/items
    def index
       render json: @container.items 
    end

    # POST /containers/:container_id/items
    def create
        item = @container.items.new(item_params)
        if item.save
            render json: item, status: :created
        else
            render json: item.errors, status: :unprocessable_entity
        end
    end

    # GET /containers/:container_id/items/:id
    def show
        if @item
            render json: @item
        else
            render json: {message: "Item not found"}, status: :bad_request
        end
    end

    # PATCH /containers/:container_id/items/:id
    def update
        if @item.update(item_params)
            render json: @item
        else
            render json: {message: "Item could not be updated"}, status: :unprocessable_entity
        end
    end

    # DELETE /containers/:container_id/items/:id
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
