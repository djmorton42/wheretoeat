require 'test_helper'

class RestaurantFlowsTest < ActionDispatch::IntegrationTest

  test "create new restaurant in in group" do

    #SETUP

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1", response.location)
    assert_equal("application/json", response.content_type)

    #TEST

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/1", response.location)
    assert_equal("application/json", response.content_type)

    body = JSON.parse(response.body)

    assert_equal(1, body["id"])
    assert_equal("My Restaurant", body["name"])
    assert_equal("123 Main Street", body["address"])
  end

  test "create new restaurant without specifying name should fail with bad request" do
    #SETUP
    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1", response.location)
    assert_equal("application/json", response.content_type)

    #TEST

    post "/user/1/group/1/restaurant",
         '{"name" : null, "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :bad_request
  end

  test "create new restaurant without specifying address should succeed" do
    #SETUP
    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1", response.location)
    assert_equal("application/json", response.content_type)

    #TEST

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant", "address" : null}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
  end

  test "creating a restaurant with the same name as a restaurant already existing in the group should fail with conflict" do

    #SETUP

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1", response.location)
    assert_equal("application/json", response.content_type)

    #TEST

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :conflict
  end


  test "creating a restaurant with the same name as a restaurant already existing in different group should succeed" do

    #SETUP

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group 1"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group 2"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/2", response.location)

    #TEST

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created

    post "/user/1/group/2/restaurant",
         '{"name" : "My Restaurant", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
  end

  test "after restaurant is created, can fetch restaurant" do
    #SETUP

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group 1"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1", response.location)

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created

    #TEST

    get "/user/1/group/1/restaurant/1"
    assert_response :ok
    body = JSON.parse(response.body)

    assert_equal(1, body["id"])
    assert_equal("My Restaurant", body["name"])
    assert_equal("123 Main Street", body["address"])
  end

  test "getting restaurant that doesn't exist should return 404" do
    #SETUP

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":"My New Group 1"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1", response.location)

    #TEST

    get "/user/1/group/1/restaurant/2"

    assert_response :not_found
  end

  #TODO Add tests for permissions to ensure groups and restaurants belong to users
end
