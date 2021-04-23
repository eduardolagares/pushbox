require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag = create(:tag)
  end

  test 'should get index' do
    get tags_url, as: :json
    assert_response :success
  end

  test 'should create tag' do
    assert_difference('Tag.count') do
      new_tag = build(:tag)
      post tags_url, params: {
        label: new_tag.label,
        name: new_tag.name
      }, as: :json
    end

    assert_response 201
  end

  test 'should show tag' do
    get tag_url(@tag), as: :json
    assert_response :success
  end

  test 'should update tag' do
    new_tag = build(:tag)
    patch tag_url(@tag), params: {
      label: new_tag.label,
      name: new_tag.name
    }, as: :json

    assert_response 200
    assert_equal json['label'], new_tag.label
    assert_equal json['name'], new_tag.name
  end

  test 'should destroy tag' do
    assert_difference('Tag.count', -1) do
      delete tag_url(@tag), as: :json
    end

    assert_response 204
  end
end
