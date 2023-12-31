require "test_helper"

class Api::V1::ContainersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @container = containers(:one)
  end

  test "should get index" do
    get api_v1_containers_url, as: :json
    assert_response :success
  end

  test "should create container" do
    assert_difference("Container.count") do
      post api_v1_containers_url, params: { container: { name: "Test Container" } }, as: :json
    end

    assert_response :created
  end

  test "should show container" do
    get api_v1_container_url(@container), as: :json
    assert_response :success
  end

  test "should update container" do
    patch api_v1_container_url(@container), params: { container: {  name: "New Container Name" } }, as: :json
    assert_response :success
  end

  test "should destroy container" do
    assert_difference("Container.count", -1) do
      delete api_v1_container_url(@container), as: :json
    end

    assert_response :ok
  end

  test "should destroy container's items when container destroyed" do
    assert_difference("Item.count", -2) do
      delete api_v1_container_url(@container), as: :json
    end

    assert_response :ok
  end
end
