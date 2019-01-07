class Latenight < ApplicationRecord
  enum section: [:Starters, :Classics, :Dishes, :A_La_Carte, :Confections]
  VALID_PRICE_REGEX = /^\d{1,4}(\.\d{0,2})?$/

  validates :name, presence: true, length: {maximum: 75}
  validates :description, presence: true, length: {maximum: 500}
  validates :price, presence: true, numericality: {greater_than: 0.0},
                                    format: {with: VALID_PRICE_REGEX, multiline: true}

  validates :section, presence: true, if: :section_present?
  
  private

    #returns true if section includes in the array above
  def section_present?
    set_section
    section.include?(section)
  end

  def set_section
    if self.section.nil?
      self.section = "Starters" 
    else
      self.section
    end
  end                                  
end
