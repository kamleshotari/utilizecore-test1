class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ROLE = ['Admin', 'Sender', 'Receiver']
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :name, presence: true
	validates :email, presence: true,
	          format: { with: URI::MailTo::EMAIL_REGEXP },
			  uniqueness: { case_sensitive: false } 

	has_one :address, dependent: :destroy
	has_many :send_parcels, foreign_key: :sender_id, class_name: 'Parcel'
	has_many :received_parcels, foreign_key: :receiver_id, class_name: 'Parcel'

	accepts_nested_attributes_for :address


	def name_with_address
		@name_with_address ||= [name, address.address_line_one, address.city, address.state, address.country, address.pincode].join('-')
	end

	def is_admin?
		self.role == "Admin"
	end
end
