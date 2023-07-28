class ContainersController < ApplicationController
    before_action :set_container, only: [:show, :update, :destroy]

    api :GET, "/containers", "List all containers"
    def index
        containers = Container.all
        render json: containers
    end

    api :POST, "/containers", "Create new container"
    param :name, String, desc: "Name of the new container", required: true
    def create
        container = Container.new(container_params)
        if container.save
            render json: container, status: :created
        else
            render json: container.errors, status: :unprocessable_entity
        end
    end

    api :GET, "/containers/:id", "Show a container"
    param :id, Integer, desc: "id of the requested container", required: true
    def show
        if @container
            render json: @container
        else
            render json: {message: "Container not found"}, status: :bad_request
        end
    end

    api :PATCH, "/containers/:id", "Modify a container"
    param :id, Integer, desc: "id of the container", required: true
    param :name, String, desc: "New name of the container", required: false
    def update
        if @container.update(container_params)
            render json: @container
        else
            render json: {message: "Container could not be updated"}, status: :unprocessable_entity
        end
    end

    api :DELETE, "/containers/:id", "Delete a container"
    param :id, Integer, desc: "id of the container", required: true
    def destroy
        @container.destroy
        head :no_content
    end

    private

    def container_params
        params.require(:container).permit(:name)
    end

    def set_container
        @container = Container.find(params[:id])
    end
end
