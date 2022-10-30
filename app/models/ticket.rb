class Ticket < ApplicationRecord

  validates_presence_of :subject
  validates_presence_of :age

  has_many :employee_tickets
  has_many :employees, through: :employee_tickets

 
  
end