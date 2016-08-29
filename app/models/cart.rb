class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    @total ||= line_items.includes(:item).reduce(0) do |sum,l_item|
      sum + (l_item.item.price * l_item.quantity)
    end
  end

  def add_item(item_id)
    @item = Item.find(item_id)
    if items.include?(@item)
      line_item = line_items.find_by(item_id: item_id)
      line_item.quantity += 1
    else
      line_item = line_items.build(item: @item, quantity: 1)
    end
    line_item
  end

  def checkout
    self.status = "submitted"
    update_inventory
  end

   def update_inventory
    if self.status = "submitted"
      self.line_items.each do |line_item|
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
        end
      end
    end
     

end
