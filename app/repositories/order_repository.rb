class OrderRepository
  def all
    Order.all
  end

  def find(id)
    Order.find(id)
  end

  def new_entity(attrs = nil)
    Order.new(attrs)
  end

  def save(order)
    order.save
  end

  def delete(order)
    order.destroy
  end
end
