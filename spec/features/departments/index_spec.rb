# As a user,
# When I visit the Department index page,
# I see each department's name and floor
# And underneath each department, I can see the names 
# of all of its employees


require "rails_helper"

RSpec.describe "Department index page" do
    before(:each) do
        @it = Department.create!(name:"IT", floor:"Basement")
        @communications = Department.create!(name:"Communications", floor:"Ground")

        @it.employees.create!(name:"Christina Aguilera", level: 2)
        @it.employees.create!(name:"Bob Jones", level: 4)

        @communications.employees.create!(name: "James Bond", level: 125)
        @communications.employees.create!(name: "Kamala Harris", level: 236)
    end

    it "should display each department's name" do
        visit "/departments"

        expect(page).to have_content("Department: IT")
        expect(page).to have_content("Department: Communications")

    end

    it "should display each department's floor" do
        visit "/departments"

        expect(page).to have_content("Floor: Basement")
        expect(page).to have_content("Floor: Ground")
        
        expect("Department: IT").to appear_before("Floor: Basement")
        expect("Floor: Basement").to appear_before("Department: Communications")
        expect("Department: Communications").to appear_before("Floor: Ground")

    end

    it "should have the names of employees underneath each department" do
        visit "/departments"

        expect("Department: IT").to appear_before("Christina Aguilera")
        expect("Christina Aguilera").to appear_before("Bob Jones")
        expect("Bob Jones").to appear_before("Department: Communications")
        expect("Department: Communications").to appear_before("James Bond")
        expect("James Bond").to appear_before("Kamala Harris")  
    
    end
end