class Address < ApplicationRecord
	validates :address_line_one, :city, :state, :country, presence: true
	validates :pincode, presence: true,
			   numericality: true,
			   length:  { minimum: 6, maximum: 6 }
	validates :mobile_number,presence: true, 
	           numericality: true,
               length:  { minimum: 8, maximum: 13 }

	belongs_to :user
end
