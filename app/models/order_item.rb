class OrderItem < ApplicationRecord
	belongs_to :order 
	belongs_to :dish

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "dish_id", "id", "order_id", "price", "quantity", "updated_at"]
  end
end
