class House
  attr_reader :price,
              :address,
              :rooms,
              :categorical_rooms,
              :total_area

  def initialize(price, address)
    @price = price.delete_prefix("$").to_i
    @address = address
    @rooms = []
  end

  def add_room(room)
    @rooms << room
  end

  def above_market_average?
    return true if price > 500000
    false
  end

  def rooms_from_category(category)
    categorical_rooms = rooms.select do |room|
      room.category == category
    end
  end

  def area
    total_area = 0
    rooms.each do |room|
      total_area += room.area
    end
    total_area
  end

  def details
    house_details = {
      "price" => price,
      "address" => address
    }
  end

  def price_per_square_foot
    (price.to_f / area).round(2)
  end

  def rooms_sorted_by_area
    rooms_by_category = @rooms.sort_by {|room| room.area}.reverse!
  end

end
