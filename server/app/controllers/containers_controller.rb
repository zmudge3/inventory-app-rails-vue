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
            render json: container, status: :created
        else
            render json: container.errors, status: :unprocessable_entity
        end
    end

    # GET /containers/:id
    def show
        if @container
            render json: ContainerSerializer.new(@container)
        else
            render json: {message: "Container not found"}, status: :bad_request
        end
    end

    # PATCH /containers/:id
    def update
        if @container.update(container_params)
            render json: @container
        else
            render json: {message: "Container could not be updated"}, status: :unprocessable_entity
        end
    end

    # DELETE /containers/:id
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
