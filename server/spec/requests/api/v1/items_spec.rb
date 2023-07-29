require 'swagger_helper'

RSpec.describe 'api/v1/items', type: :request do

  path '/api/v1/containers/{container_id}/items' do
    parameter name: 'container_id', in: :path, type: :string, description: 'container id'

    get('lists items for a container') do
      tags "Items"
      consumes "application/json"

      response(200, "items found") do
        let(:container_id) { Container.last.id }
 
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

    post('adds a new item to a container') do
      tags "Items"
      consumes "application/json"

      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          quantity: { type: :number }
        },
        required: ["name", "quantity"]
      }

      response(201, "item created") do
        let(:container_id) { Container.last.id }
        let(:item) { { name: "New Item", quantity: 1 } }
        run_test!
      end

      response(422, "invalid request") do
        let(:container_id) { Container.last.id }
        let(:item) { { name: "test" } }
        run_test!

        let(:container_id) { Container.last.id }
        let(:item) { { not_a_param: "test" } }
        run_test!
      end

      response(404, "container not found") do
        let(:container_id) { Container.last.id + 1 }
        let(:item) { { name: "New Item", quantity: 1 } }
        run_test!
      end
    end
  end

  path '/api/v1/containers/{container_id}/items/{id}' do
    parameter name: 'container_id', in: :path, type: :string, description: 'container id'
    parameter name: 'id', in: :path, type: :string, description: 'item id'

    get('retrieves an item') do
      tags "Items"
      consumes "application/json"

      response(200, "item found") do
        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, "container or item not found") do
        let(:container_id) { Container.last.id + 1 }
        let(:id) { Item.last.id }
        run_test!

        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id + 1 }
        run_test!
      end
    end

    patch('updates an item') do
      tags "Items"
      consumes "application/json"

      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          quantity: { type: :number }
        }
      }

      response(200, "item updated") do
        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id }
        let(:item) { { name: "Updated Item Name" } }
        run_test!

        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id }
        let(:item) { { quantity: 8 } }
        run_test!

        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id }
        let(:item) { { name: "Updated Item Name", quantity: 10 } }
        run_test!
      end

      response(404, "container or item not found") do
        let(:container_id) { Container.last.id + 1 }
        let(:id) { Item.last.id }
        let(:item) { { name: "Updated Item Name" } }
        run_test!

        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id + 1 }
        let(:item) { { name: "Updated Item Name" } }
        run_test!
      end
    end

    delete('deletes an item from a container') do
      tags "Items"
      consumes "application/json"

      response(200, "item deleted") do
        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id }
        run_test!
      end

      response(404, "container or item not found") do
        let(:container_id) { Container.last.id + 1 }
        let(:id) { Item.last.id }
        run_test!

        let(:container_id) { Container.last.id }
        let(:id) { Item.last.id + 1 }
        run_test!
      end
    end
  end
end
