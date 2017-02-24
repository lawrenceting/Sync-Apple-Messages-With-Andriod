require 'test_helper'

class BuddiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @buddy = buddies(:one)
  end

  test "should get index" do
    get buddies_url
    assert_response :success
  end

  test "should get new" do
    get new_buddy_url
    assert_response :success
  end

  test "should create buddy" do
    assert_difference('Buddy.count') do
      post buddies_url, params: { buddy: { buddyid: @buddy.buddyid, fullname: @buddy.fullname } }
    end

    assert_redirected_to buddy_url(Buddy.last)
  end

  test "should show buddy" do
    get buddy_url(@buddy)
    assert_response :success
  end

  test "should get edit" do
    get edit_buddy_url(@buddy)
    assert_response :success
  end

  test "should update buddy" do
    patch buddy_url(@buddy), params: { buddy: { buddyid: @buddy.buddyid, fullname: @buddy.fullname } }
    assert_redirected_to buddy_url(@buddy)
  end

  test "should destroy buddy" do
    assert_difference('Buddy.count', -1) do
      delete buddy_url(@buddy)
    end

    assert_redirected_to buddies_url
  end
end
