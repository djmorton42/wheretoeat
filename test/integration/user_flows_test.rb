require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  test "create new user" do

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)
    assert_equal("application/json", response.content_type)

    body = JSON.parse(response.body)

    assert_equal(1, body["id"])
    assert_equal("testuser@example.com", body["email"])
    assert(body["is_active"])
    assert(body["password_hash"].length == 64)
    assert(body["salt"].length == 64)
  end

  test "create new user without specifying email should fail with bad request" do

    post "/user",
         '{"email":null, "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }
  end

  test "create new user without specifying password should fail with bad request" do

    post "/user",
         '{"email":"testuser@example.com", "password":null}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :bad_request
  end

  test "creating a user with the same email as an existing user fails" do

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created

    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :conflict
  end

  test "after user is created, can fetch user" do
    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created

    get "/user/1"

    assert_response :ok

    body = JSON.parse(response.body)

    assert_equal(1, body["id"])
    assert_equal("testuser@example.com", body["email"])
    assert(body["is_active"])
    assert(body["password_hash"].length == 64)
    assert(body["salt"].length == 64)
  end

  test "getting user that doesn't exist should return 404" do
    get "/user/1"

    assert_response :not_found
  end
end
