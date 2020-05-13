class House
  attr_reader :price,
              :address,
              :rooms,
              :categorical_rooms

  def initialize(price, address)
    @price = price.delete_prefix("$").to_i
    @address = address
    @rooms = []
    @categorical_rooms = []
  end

  def add_room(room)
    @rooms << room
  end

  def above_market_average?
    return true if price > 500000
    false
  end

  def rooms_from_category(category)
    @categorical_rooms = rooms.select do |room|
      room.category == category
    end
  end

end
