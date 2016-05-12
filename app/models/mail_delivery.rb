class MailDelivery < ActiveRecord::Base
  has_and_belongs_to_many :routes

  #represents a single peice of mail traveling through the system
end
