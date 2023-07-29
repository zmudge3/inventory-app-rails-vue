class Api::V1::ItemsController < ApplicationController
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
        render json: ItemSerializer.new(@item)
    end

    # PATCH /containers/:container_id/items/:id
    def update
        @item.update(item_params)
        render json: ItemSerializer.new(@item), status: :ok
    end

    # DELETE /containers/:container_id/items/:id
    def destroy
        @item.destroy
        render json: { message: "Item successfully deleted" }, status: :ok
    end

    private

    def item_params
        params.permit(:name, :quantity)
    end

    def set_container
        @container = Container.find_by_id(params[:container_id])
        render json: { error: "Container not found" }, status: :not_found unless @container
    end

    def set_container_item
        @item = @container.items.find_by_id(params[:id]) if @container
        render json: { error: "Item not found" }, status: :not_found unless @item
    end
end
