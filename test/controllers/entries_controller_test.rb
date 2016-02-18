require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    @entry = entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entry" do
    assert_difference('Entry.count') do
      post :create, entry: { author_id: @entry.author_id, body: @entry.body, comment_id: @entry.comment_id, day: @entry.day, image_url_list: @entry.image_url_list, publicshed: @entry.publicshed, title: @entry.title, week: @entry.week, yearmonth: @entry.yearmonth }
    end

    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should show entry" do
    get :show, id: @entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entry
    assert_response :success
  end

  test "should update entry" do
    patch :update, id: @entry, entry: { author_id: @entry.author_id, body: @entry.body, comment_id: @entry.comment_id, day: @entry.day, image_url_list: @entry.image_url_list, publicshed: @entry.publicshed, title: @entry.title, week: @entry.week, yearmonth: @entry.yearmonth }
    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should destroy entry" do
    assert_difference('Entry.count', -1) do
      delete :destroy, id: @entry
    end

    assert_redirected_to entries_path
  end
end
