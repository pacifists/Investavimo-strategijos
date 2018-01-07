require 'test_helper'

class StockInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_info = stock_infos(:one)
  end

  test "should get index" do
    get stock_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_info_url
    assert_response :success
  end

  test "should create stock_info" do
    assert_difference('StockInfo.count') do
      post stock_infos_url, params: { stock_info: { adj_close: @stock_info.adj_close, close: @stock_info.close, high: @stock_info.high, low: @stock_info.low, open: @stock_info.open, stock_date: @stock_info.stock_date, stock_id: @stock_info.stock_id, volume: @stock_info.volume } }
    end

    assert_redirected_to stock_info_url(StockInfo.last)
  end

  test "should show stock_info" do
    get stock_info_url(@stock_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_info_url(@stock_info)
    assert_response :success
  end

  test "should update stock_info" do
    patch stock_info_url(@stock_info), params: { stock_info: { adj_close: @stock_info.adj_close, close: @stock_info.close, high: @stock_info.high, low: @stock_info.low, open: @stock_info.open, stock_date: @stock_info.stock_date, stock_id: @stock_info.stock_id, volume: @stock_info.volume } }
    assert_redirected_to stock_info_url(@stock_info)
  end

  test "should destroy stock_info" do
    assert_difference('StockInfo.count', -1) do
      delete stock_info_url(@stock_info)
    end

    assert_redirected_to stock_infos_url
  end
end
