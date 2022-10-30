class Department < ApplicationRecord

  validates_presence_of :name
  validates_presence_of :floor

  has_many :employees

  # def dept_employee_names
  #   @employee_names = []
  #   employees.each do |employee|
  #    @employee_names << employee.name
  #   end
  #   @employee_names
  # end 
end