require 'swagger_helper'

RSpec.describe 'api/v1/containers', type: :request do

  path '/api/v1/containers' do

    get('lists containers') do
      tags "Containers"
      consumes "application/json"
 
      response(200, "containers found") do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post("creates container") do
      tags "Containers"
      consumes "application/json"

      parameter name: :container, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ["name"]
      }

      response(201, "container created") do
        let(:container) { { name: "New Container"} }
        run_test!
      end

      response(422, "invalid request") do
        let(:container) { { not_a_param: "test" } }
        run_test!
      end
    end
  end

  path '/api/v1/containers/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'container id'
    
    get("retrieves a container") do
      tags "Containers"
      consumes "application/json"

      response(200, "container found") do
        let(:id) { Container.last.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, "container not found") do
        let(:id) { Container.last.id + 1 }
        run_test!
      end
    end

    patch("updates a container") do
      tags "Containers"
      consumes "application/json"

      parameter name: :container, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        }
      }

      response(200, "container updated") do
        let(:id) { Container.last.id }
        let(:container) { { name: "Updated Container Name" } }
        run_test!
      end

      response(404, "container not found") do
        let(:id) { Container.last.id + 1}
        let(:container) { { name: "Updated Container Name" } }
        run_test!
      end
    end

    delete("deletes a container") do
      tags "Containers"
      consumes "application/json"

      response(200, "container deleted") do
        let(:id) { Container.last.id }
        run_test!
      end

      response(404, "container not found") do
        let(:id) { Container.last.id + 1}
        run_test!
      end
    end
  end
end
