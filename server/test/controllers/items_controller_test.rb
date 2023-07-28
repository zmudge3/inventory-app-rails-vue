require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @container = containers(:one)
    @item = items(:one)
  end

  test "should get index" do
    get container_items_url(@container), as: :json
    assert_response :success
  end

  test "should create item" do
    assert_difference("Item.count") do
      post container_items_url(@container), params: { item: { name: "Test Item", quantity: 3 } }, as: :json
    end

    assert_response :created
  end

  test "should fail to create item when name not provided" do
      post container_items_url(@container), params: { item: { quantity: 3 } }, as: :json
      assert_response :unprocessable_entity
  end

  test "should show item" do
    get container_item_url(@container, @item), as: :json
    assert_response :success
  end

  test "should update item" do
    patch container_item_url(@container, @item), params: { item: { name: "New Item Name", quantity: 2 } }, as: :json
    assert_response :success
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete container_item_url(@container, @item), as: :json
    end

    assert_response :ok
  end
end
