require 'minitest/autorun'
require 'minitest/pride'
require './lib/room'
require './lib/house'

class HouseTest < Minitest::Test
  def setup
    @house = House.new("$400000", "123 sugar lane")
    @room_1 = Room.new(:bedroom, 10, '13') #130
    @room_2 = Room.new(:bedroom, 11, '15') #165
    @room_3 = Room.new(:living_room, 25, '15') #375
    @room_4 = Room.new(:basement, 30, '41') #1230
  end

  def test_it_exists
    assert_instance_of House, @house
  end

  def test_it_has_a_price_and_address
    assert_equal 400000, @house.price
    assert_equal '123 sugar lane', @house.address
  end

  def test_it_has_no_rooms_by_default
    assert_equal [], @house.rooms
  end

  def test_it_can_add_rooms
    assert_equal [], @house.rooms
    @house.add_room (@room_1)
    @house.add_room (@room_2)
    assert_equal [@room_1, @room_2], @house.rooms
  end

  def test_it_is_above_market_average
    assert_equal false, @house.above_market_average?

    expensive_house = House.new("$600000", '987 strawberry fields ave')
    assert_equal true, expensive_house.above_market_average?
  end

  def test_a_house_has_rooms_from_categories
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)

    assert_equal [@room_1, @room_2], @house.rooms_from_category(:bedroom)
    assert_equal [@room_4], @house.rooms_from_category(:basement)
  end

  def test_it_can_calculate_total_area
    assert_nil nil, @house.area
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)

    assert_equal 1900, @house.area
  end

  def test_it_has_details
    house_hash = {
      'price' => 400000,
      'address' => '123 sugar lane'
    }
    assert_equal house_hash, @house.details
  end

  def test_it_has_price_per_square_foot
    @house.add_room(@room_4)
    @house.add_room(@room_1)
    @house.add_room(@room_3)
    @house.add_room(@room_2)

    assert_equal 210.53, @house.price_per_square_foot
  end

  def test_it_can_sort_rooms_by_area
    @house.add_room(@room_4)
    @house.add_room(@room_1)
    @house.add_room(@room_3)
    @house.add_room(@room_2)

    assert_equal [@room_4, @room_3, @room_2, @room_1], @house.rooms_sorted_by_area
  end

end
