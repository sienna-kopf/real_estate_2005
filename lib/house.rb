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
    rooms_by_area = @rooms.sort_by {|room| room.area}.reverse!
  end

  def rooms_by_category
    rooms_by_category = Hash.new

    room_keys = rooms.map do |room|
      rooms_by_category.keys << room.category
    end

    room_keys = room_keys.flatten!.uniq

    rooms.each do |room|
      room_keys.each do |key|
        if room.category == key
          rooms_by_category[key] = room
        end
      end
    end

    # rooms_by_category.each_value do |_, room_category|
    #   rooms_by_category[room_category].to_a
    # end

    rooms_by_category

    # rooms_by_category = Hash.new{|hsh, key| hsh[key] = []}
    #
    #
    #
    # # rooms_by_category.each do |categories, rooms|
    # #   rooms.each do |room|
    # #     if room.category == categories
    # #       rooms_by_category.push "room"
    # #     end
    # #   end
    # # end
    # #
    # # rooms_by_category
  end


end
