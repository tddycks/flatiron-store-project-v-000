class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items


  def total
    line_items.inject(0) { |sum, li| sum + li.item.price * li.quantity }
    #line_items.map { |i| i.item.price * i.quantity }.sum
  end

  def add_item(item_id)
    line_item = LineItem.find_by(item_id: item_id)
    if line_item
      line_item.quantity += 1
      line_item
    else
      self.line_items.build(item_id: item_id)
    end
  end

  def update_inventory
    self.line_items.each do |li|
      item = Item.find_by(id: li.item_id)
      item.inventory -= li.quantity
      item.save
    end
  end
end
