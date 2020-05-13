class House
  attr_reader :price,
              :address

  def initialize(price, address)
    @price = price.delete_prefix("$").to_i
    @address = address
  end

end
