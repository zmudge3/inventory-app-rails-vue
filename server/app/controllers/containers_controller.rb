class ContainersController < ApplicationController
    before_action :set_container, only: [:show, :update, :destroy]

    # GET /containers
    def index
        containers = Container.all
        render json: ContainerSerializer.new(containers)
    end

    # POST /containers
    def create
        container = Container.new(container_params)
        if container.save
            render json: ContainerSerializer.new(container), status: :created
        else
            render json: { error: "Container creation failed" }, status: :unprocessable_entity
        end
    end

    # GET /containers/:id
    def show
        if @container
            render json: ContainerSerializer.new(@container), status: :ok
        else
            render json: { error: "Container not found" }, status: :not_found
        end
    end

    # PATCH /containers/:id
    def update
        if @container.update(container_params)
            render json: ContainerSerializer.new(@container), status: :ok
        else
            render json: { error: "Container update failed" }, status: :unprocessable_entity
        end
    end

    # DELETE /containers/:id
    def destroy
        if @container.destroy
            render json: { message: "Container successfully deleted" }, status: :ok
        else
            render json: { error: "Container deletion failed" }, status: :internal_server_error
        end
    end

    private

    def container_params
        params.require(:container).permit(:name)
    end

    def set_container
        @container = Container.find(params[:id])
    end
end
