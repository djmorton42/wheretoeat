require 'test_helper'

class GroupFlowsTest < ActionDispatch::IntegrationTest

  test "create new group under existing user should succeed" do

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

    body = JSON.parse(response.body)

    assert_equal(1, body["id"])
    assert_equal("My New Group", body["name"])
  end

  test "create new group under non-existant user should fail with not found" do#
    post "/user/1/group",
         '{"name":"My New Group"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :not_found
  end

  test "create new group without specifying name should fail with bad request" do
    post "/user",
         '{"email":"testuser@example.com", "password":"mypassword"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1", response.location)

    post "/user/1/group",
         '{"name":null}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :bad_request
  end
end