# As a user,
# When I visit the Employee show page,
# I see the employee's name, their department,
# and a list of all of their tickets from oldest to newest.
# I also see the oldest ticket assigned to the employee listed 
#separately.

require "rails_helper"

RSpec.describe "Emplee show page" do 
    before(:each) do
        @it = Department.create!(name:"IT", floor:"Basement")
        @communications = Department.create!(name:"Communications", floor:"Ground")

        @it.employees.create!(name:"Christina Aguilera", level: 2)
        @it.employees.create!(name:"Bob Jones", level: 4)

        @communications.employees.create!(name: "James Bond", level: 125)
        @employee_4 = @communications.employees.create!(name: "Kamala Harris", level: 236)
    end

    it "shows the employee's name and department" do
        visit "/employees/#{@employee_4.id}"

        expect(page).to have_content("Kamala Harris")
        expect(page).to have_content("Communications")

    end

    xit "shows a list of all the employee's tickets oldest to newest" do
    end

    xit "shows the oldest ticket listed separately" do
    end
end