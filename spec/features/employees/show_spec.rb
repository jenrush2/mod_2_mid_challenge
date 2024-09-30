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

        @employee_3 = @communications.employees.create!(name: "James Bond", level: 125)
        @employee_4 = @communications.employees.create!(name: "Kamala Harris", level: 236)

        @ticket_1 = @employee_4.tickets.create!(subject:"printers broken", age: 5)
        @ticket_2 = @employee_4.tickets.create!(subject:"hallway vandalized", age: 2)
        @ticket_3 = @employee_4.tickets.create!(subject:"chair broken", age: 3)

        @ticket_4 = @employee_3.tickets.create!(subject:"blood in hallway", age: 6)


    end

    it "shows the employee's name and department" do
        visit "/employees/#{@employee_4.id}"

        expect(page).to have_content("Kamala Harris")
        expect(page).to have_content("Communications")
        expect(page).to_not have_content("James Bond")

    end

    it "shows a list of all the employee's tickets oldest to newest" do
        visit "/employees/#{@employee_4.id}"
        
        expect("printers broken").to appear_before("chair broken")
        expect("chair broken").to appear_before("hallway vandalized")
    
    end

    it "shows the oldest ticket listed separately" do
        visit "/employees/#{@employee_4.id}"
      
        expect("Oldest Ticket: printers broken").to appear_before("Other Tickets:")
        expect("Other Tickets:").to appear_before("chair broken")
        expect("chair broken").to appear_before("hallway vandalized")
        
    end
end