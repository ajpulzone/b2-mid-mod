require "rails_helper"

RSpec.describe "departments index page", type: :feature do

  before(:each) do
    @department_1 = Department.create!(name: "Clothing", floor: 3)
    @department_2 = Department.create!(name: "Grocery", floor: 1)
    @department_3 = Department.create!(name: "Hardware", floor: 2)
    @employee_1 = @department_1.employees.create!(name: "Tiana Frank", level: 4)
    @employee_2 = @department_1.employees.create!(name: "Hudson Brand", level: 1)
    @employee_3 = @department_2.employees.create!(name: "Sam Waters", level: 5)
    @employee_4 = @department_3.employees.create!(name: "Leslie Winkle", level: 2)
  end

  it "shows each departments' name and floor" do
    visit "/departments" 
    # save_and_open_page

    within("#department-#{@department_1.id}") do
      expect(page).to have_content("Department: Clothing")
      expect(page).to have_content("Floor: 3")
    end 

    within("#department-#{@department_2.id}") do
      expect(page).to have_content("Department: Grocery")
      expect(page).to have_content("Floor: 1")
    end 

    within("#department-#{@department_3.id}") do
      expect(page).to have_content("Department: Hardware")
      expect(page).to have_content("Floor: 2")
    end

    within("#department-#{@department_1.id}") do
      expect(page).to have_no_content("Department: Hardware")
      expect(page).to have_no_content("Floor: 1")
    end 

    within("#department-#{@department_2.id}") do
      expect(page).to have_no_content("Department: Clothing")
      expect(page).to have_no_content("Floor: 3")
    end
  end

  it "under each department it lists the names of all of its employees" do
    visit "/departments"

    within("#department-#{@department_1.id}") do
      expect(page).to have_content("Tiana Frank")
      expect(page).to have_content("Hudson Brand")
    end 

    within("#department-#{@department_2.id}") do
      expect(page).to have_content("Sam Waters")
    end 

    within("#department-#{@department_3.id}") do
      expect(page).to have_content("Leslie Winkle")
    end 

    within("#department-#{@department_1.id}") do
      expect(page).to have_no_content("Sam Waters")
      expect(page).to have_no_content("Leslie Winkle")
    end
  end
end