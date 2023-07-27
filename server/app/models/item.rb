class Item < ApplicationRecord
    belongs_to :container
    validates_presence_of :name, :quantity
end
