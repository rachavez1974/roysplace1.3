class Address < ApplicationRecord
  belongs_to :user
  has_many :users

  enum address_type: [:Business, :Military, :Residence]
  enum unit_type: [:None, :Apt, :Floor, :Suite]

  validates  :street_address, presence: true, length: {maximum: 150}
  validates  :address_type, presence: true, if: :address_type_present?
  validates  :unit_type, presence: true, if: :unit_type_present?
  validates  :number, presence: true
  validates  :city, presence: true, length: {in: 2..50}
  validates  :state, presence: true, length: {in: 2..50}
  validates  :zipcode, presence: true, length: {maximum: 5}



  private

  #returns true if address_type includes in the array above
  def address_type_present?
    address_type.include?(address_type)
  end

  #returns true if unit_type includes in the array above
  def unit_type_present?
    unit_type.include?(unit_type)
  end



  
end
