require "rails_helper"

RSpec.describe "employee show page", type: :feature do

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
    @employee_ticket_7 = EmployeeTicket.create!(employee: @employee_2, ticket: @ticket_8)
    @employee_ticket_5 = EmployeeTicket.create!(employee: @employee_3, ticket: @ticket_4)
    @employee_ticket_6 = EmployeeTicket.create!(employee: @employee_3, ticket: @ticket_6)
  end

  it "shows the name and department of the specified employee" do

    visit "/employees/#{@employee_1.id}"

   within("#employee-#{@employee_1.id}") do
      expect(page).to have_content("Department: Clothing")
      expect(page).to have_content("Name: Tiana Frank")
    end
  end

  it "has a list of all of the specified employees tickets sorted from oldest to newest" do

    visit "/employees/#{@employee_1.id}"

    within("#employee-#{@employee_1.id}") do
      expect(@ticket_8.subject).to appear_before(@ticket_6.subject)
      expect(@ticket_6.subject).to appear_before(@ticket_7.subject)
      expect(@ticket_7.subject).to_not appear_before(@ticket_6.subject)
      expect(@ticket_6.subject).to_not appear_before(@ticket_8.subject)
    end
  end

  it "has the oldest ticket listed out seperately in addition to being in the original list" do

    visit "/employees/#{@employee_1.id}"

    within("#oldestticket-#{@employee_1.id}") do
      expect(page).to have_content(@ticket_8.subject)
      expect(page).to have_no_content(@ticket_6.subject)
      expect(page).to have_no_content(@ticket_7.subject)
    end
  end

  it "does not show any tickets that do not belong to the specified employee" do
    
    visit "/employees/#{@employee_1.id}" 

      expect(page).to have_no_content(@ticket_3.subject)
      expect(page).to have_no_content(@ticket_4.subject)
      expect(page).to have_no_content(@ticket_5.subject)
      expect(page).to have_no_content(@ticket_2.subject)
  end

  it "has a form to add a ticket to 'this employee'" do

    visit "/employees/#{@employee_1.id}"

    have_selector?("form")

  end

  it "when user fills in the form with the id of a ticket that already exists
    in the database and they click submit, they are redirected to the specified
    employee's show page and the ticket's subject is now listed" do

      visit "/employees/#{@employee_1.id}"

      # save_and_open_page

      within("#employee-#{@employee_1.id}") do
        expect(page).to have_no_content(@ticket_4.subject)
      end

      fill_in :id, with: "#{@ticket_4.id}"
      click_on "Submit"

      # ticket = Ticket.last

      expect(current_path).to eq("/employees/#{@employee_1.id}")

      within("#employee-#{@employee_1.id}") do
        expect(page).to have_content(@ticket_4.subject)
      end
  end

  xit "shows the specified employees level" do

    visit "/employees/#{@employee_1.id}"

    within("#employee-#{@employee_1.id}") do
      expect(page).to have_content("Level: 4")
      expect(page).to have_no_content(@employee_4)
    end
  end

  xit "has a unique list of all the other employees that this employee 
    shares tickets with" do

     within("#sharetickets-#{@employee_1.id}") do
      expect(page).to have_content(@employee_2)
      expect(page).to have_content(@employee_3)
      expect(page).to have_no_content(@employee_4)
    end
  end 
end