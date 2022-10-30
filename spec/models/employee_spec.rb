require 'rails_helper'

RSpec.describe Employee, type: :model do

  before(:each) do
    @department_1 = Department.create!(name: "Clothing", floor: 3)
    @department_2 = Department.create!(name: "Grocery", floor: 1)
    @department_3 = Department.create!(name: "Hardware", floor: 2)
    @employee_1 = @department_1.employees.create!(name: "Tiana Frank", level: 4)
    @employee_2 = @department_1.employees.create!(name: "Hudson Brand", level: 1)
    @employee_3 = @department_2.employees.create!(name: "Sam Waters", level: 5)
    @employee_4 = @department_3.employees.create!(name: "Leslie Winkle", level: 2)
    @ticket_1 = Ticket.create!(subject: "Shirt Returned Filthy", age: 3)
    @ticket_2 = Ticket.create!(subject: "Leaky Faucet", age: 1)
    @ticket_3 = Ticket.create!(subject: "Crayon Marks On Dryer", age: 4)
    @ticket_4 = Ticket.create!(subject: "Broken Eggs", age: 5)
    @ticket_5 = Ticket.create!(subject: "Spoiled Milk", age: 8)
    @ticket_6 = Ticket.create!(subject: "Ripped Seam", age: 6)
    @ticket_7 = Ticket.create!(subject: "Broken Zipper", age: 2)
    @ticket_8 = Ticket.create!(subject: "Grass Stains On Knees", age: 7)
    @employee_ticket_1 = EmployeeTicket.create!(employee: @employee_1, ticket: @ticket_6)
    @employee_ticket_2 = EmployeeTicket.create!(employee: @employee_1, ticket: @ticket_7)
    @employee_ticket_3 = EmployeeTicket.create!(employee: @employee_1, ticket: @ticket_8)
    @employee_ticket_4 = EmployeeTicket.create!(employee: @employee_2, ticket: @ticket_1)
    @employee_ticket_5 = EmployeeTicket.create!(employee: @employee_3, ticket: @ticket_4)
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:level)}
  end

  describe 'relationships' do
    it {should belong_to(:department)}
    it {should have_many(:employee_tickets)}
    it {should have_many(:tickets).through(:employee_tickets)}
  end

  describe "#desc_employee_tickets" do
    it "should return a list of tickets for the specified employee in order 
      of oldest to newest" do
        expect(@employee_1.desc_employee_tickets).to eq([@ticket_8, @ticket_6, @ticket_7])
        expect(@employee_1.desc_employee_tickets).to_not eq([@ticket_6, @ticket_7, @ticket_8])
    end
  end
end