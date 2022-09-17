class Parcel < ApplicationRecord

	STATUS = ['Sent', 'In Transit', 'Delivered']
	PAYMENT_MODE = ['COD', 'Prepaid']

	validates :weight, :status, presence: true
	validates :status, inclusion: STATUS
	validates :payment_mode, inclusion: PAYMENT_MODE
	validates :cost, presence: true
	validates :guid, presence: true,
	          uniqueness: true

	belongs_to :service_type
	belongs_to :sender, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	before_validation :set_guid, on: :create

	after_create :send_notification

	def set_guid
		self.guid = SecureRandom.uuid
	end

	private

	def send_notification
		UserMailer.with(parcel: self).status_email.deliver_later
	end

end
