class Employee < ApplicationRecord
  
  validates_presence_of :name
  validates_presence_of :level

  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

   def desc_employee_tickets
    tickets.order(age: :desc)
  end

  def shared_tickets
    binding.pry
  end
end