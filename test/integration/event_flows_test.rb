require 'test_helper'

class EventFlowsTest < ActionDispatch::IntegrationTest
  test "create new restaurant in a group" do

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

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 1", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/1", response.location)

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 2", "address" : "234 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/2", response.location)

    #TEST

    post "/user/1/group/1/event",
         '{"title": "Going for lunch", ' +
         ' "description":"Team lunch", ' +
         ' "event_datetime":1455850800, ' +
         ' "voting_start_datetime":1455850200, ' +
         ' "voting_end_datetime":1455850800, ' +
         ' "voters":["blah@example.com", "blech@example.com"],' +
         ' "restaurants":[' +
         '   "/user/1/group/1/restaurant/1", ' +
         '   "/user/1/group/1/restaurant/2" ' +
         ' ]' +
         '}',
         { 'CONTENT_TYPE' => 'application/json' }

    body = JSON.parse(response.body)

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/event/1", response.location)

    assert_equal(1, body["id"])
    assert_equal("Going for lunch", body["title"])
    assert_equal("Team lunch", body["description"])
    assert_equal("2016-02-19T03:00:00.000Z", body["event_datetime"])
    assert_equal("2016-02-19T02:50:00.000Z", body["voting_start_datetime"])
    assert_equal("2016-02-19T03:00:00.000Z", body["voting_end_datetime"])

    assert(body["voters"].length == 2)
    assert(body["voters"].include? "blah@example.com")
    assert(body["voters"].include? "blech@example.com")

    assert(body["restaurants"].length == 2)
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/1")
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/2")
  end

  test "after event is created, it can be fetched with get" do

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

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 1", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/1", response.location)

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 2", "address" : "234 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/2", response.location)

    post "/user/1/group/1/event",
         '{"title": "Going for lunch", ' +
         ' "description":"Team lunch", ' +
         ' "event_datetime":1455850800, ' +
         ' "voting_start_datetime":1455850200, ' +
         ' "voting_end_datetime":1455850800, ' +
         ' "voters":["blah@example.com", "blech@example.com"],' +
         ' "restaurants":[' +
         '   "/user/1/group/1/restaurant/1", ' +
         '   "/user/1/group/1/restaurant/2" ' +
         ' ]' +
         '}',
         { 'CONTENT_TYPE' => 'application/json' }

    body = JSON.parse(response.body)

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/event/1", response.location)

    #TEST

    get "/user/1/group/1/event/1"

    assert_response :ok

    assert_equal(1, body["id"])
    assert_equal("Going for lunch", body["title"])
    assert_equal("Team lunch", body["description"])
    assert_equal("2016-02-19T03:00:00.000Z", body["event_datetime"])
    assert_equal("2016-02-19T02:50:00.000Z", body["voting_start_datetime"])
    assert_equal("2016-02-19T03:00:00.000Z", body["voting_end_datetime"])

    assert(body["voters"].length == 2)
    assert(body["voters"].include? "blah@example.com")
    assert(body["voters"].include? "blech@example.com")

    assert(body["restaurants"].length == 2)
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/1")
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/2")
  end

  test "after event is created, a user can be added via patch" do

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

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 1", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/1", response.location)

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 2", "address" : "234 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/2", response.location)

    post "/user/1/group/1/event",
         '{"title": "Going for lunch", ' +
         ' "description":"Team lunch", ' +
         ' "event_datetime":1455850800, ' +
         ' "voting_start_datetime":1455850200, ' +
         ' "voting_end_datetime":1455850800, ' +
         ' "voters":["blah@example.com", "blech@example.com"],' +
         ' "restaurants":[' +
         '   "/user/1/group/1/restaurant/1", ' +
         '   "/user/1/group/1/restaurant/2" ' +
         ' ]' +
         '}',
         { 'CONTENT_TYPE' => 'application/json' }

    body = JSON.parse(response.body)

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/event/1", response.location)

    #TEST

    patch "/user/1/group/1/event/1",
          '[' +
          '{ "op": "add", "path":"/voters", "value":"abc@example.com"}' +
          ']',
          { 'CONTENT_TYPE' => "application/json-patch+json"}

    assert_response :ok

    get "/user/1/group/1/event/1"

    assert_response :ok
    body = JSON.parse(response.body)

    assert_equal(1, body["id"])
    assert_equal("Going for lunch", body["title"])
    assert_equal("Team lunch", body["description"])
    assert_equal("2016-02-19T03:00:00.000Z", body["event_datetime"])
    assert_equal("2016-02-19T02:50:00.000Z", body["voting_start_datetime"])
    assert_equal("2016-02-19T03:00:00.000Z", body["voting_end_datetime"])

    assert(body["voters"].length == 3)
    assert(body["voters"].include? "blah@example.com")
    assert(body["voters"].include? "blech@example.com")
    assert(body["voters"].include? "abc@example.com")

    assert(body["restaurants"].length == 2)
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/1")
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/2")

  end


  test "event can be updated via put, including adding and removing voters and restaurants" do

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

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 1", "address" : "123 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/1", response.location)

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 2", "address" : "234 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/2", response.location)

    post "/user/1/group/1/restaurant",
         '{"name" : "My Restaurant 3", "address" : "345 Main Street"}',
         { 'CONTENT_TYPE' => 'application/json' }

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/restaurant/3", response.location)


    post "/user/1/group/1/event",
         '{"title": "Going for lunch", ' +
         ' "description":"Team lunch", ' +
         ' "event_datetime":1455850800, ' +
         ' "voting_start_datetime":1455850200, ' +
         ' "voting_end_datetime":1455850800, ' +
         ' "voters":["blah@example.com", "blech@example.com"],' +
         ' "restaurants":[' +
         '   "/user/1/group/1/restaurant/1", ' +
         '   "/user/1/group/1/restaurant/2" ' +
         ' ]' +
         '}',
         { 'CONTENT_TYPE' => 'application/json' }

    body = JSON.parse(response.body)

    assert_response :created
    assert_equal("http://www.example.com/user/1/group/1/event/1", response.location)

    #TEST

    put "/user/1/group/1/event/1",
         '{"title": "Going for a lunch", ' +
         ' "description":"A Team lunch", ' +
         ' "event_datetime":1455850500, ' +
         ' "voting_start_datetime":1455849900, ' +
         ' "voting_end_datetime":1455850500, ' +
         ' "voters":["blech@example.com", "abc@example.com"],' +
         ' "restaurants":[' +
         '   "/user/1/group/1/restaurant/2", ' +
         '   "/user/1/group/1/restaurant/3" ' +
         ' ]' +
         '}',
        { 'CONTENT_TYPE' => 'application/json' }

    assert_response :ok

    get "/user/1/group/1/event/1"

    assert_response :ok
    body = JSON.parse(response.body)

    assert_equal(1, body["id"])
    assert_equal("Going for a lunch", body["title"])
    assert_equal("A Team lunch", body["description"])
    assert_equal("2016-02-19T02:55:00.000Z", body["event_datetime"])
    assert_equal("2016-02-19T02:45:00.000Z", body["voting_start_datetime"])
    assert_equal("2016-02-19T02:55:00.000Z", body["voting_end_datetime"])

    assert(body["voters"].length == 2)
    assert(body["voters"].include? "blech@example.com")
    assert(body["voters"].include? "abc@example.com")

    assert(body["restaurants"].length == 2)
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/2")
    assert(body["restaurants"].include? "/user/1/group/1/restaurant/3")
  end


end