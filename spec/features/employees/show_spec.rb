# As a user,
# When I visit the Employee show page,
# I see the employee's name, their department,
# and a list of all of their tickets from oldest to newest.
# I also see the oldest ticket assigned to the employee listed 
#separately.

# As a user,
# When I visit the employee show page,
# I do not see any tickets listed that are not assigned to the employee
# and I see a form to add a ticket to this employee.
# When I fill in the form with the id of a ticket that already 
# exists in the database and I click submit
# Then I am redirected back to that employees show page
# and I see the ticket's subject now listed.
# (you do not have to test for sad path, for example if the id 
# does not match an existing ticket.)

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
        expect(page).to_not have_content("blood in hallway")

    end

    it "shows a list of all the employee's tickets oldest to newest" do
        visit "/employees/#{@employee_4.id}"
        
        expect("printers broken").to appear_before("chair broken")
        expect("chair broken").to appear_before("hallway vandalized")
        expect(page).to_not have_content("James Bond")
    
    end

    it "shows the oldest ticket listed separately" do
        visit "/employees/#{@employee_4.id}"
      
        expect("Oldest Ticket: printers broken").to appear_before("Other Tickets:")
        expect("Other Tickets:").to appear_before("chair broken")
        expect("chair broken").to appear_before("hallway vandalized")
        
    end

    it "has a form to add a ticket" do
        visit "/employees/#{@employee_4.id}"

        expect(page).to have_field("ticket_id")
        expect(page).to have_button("Add Ticket to Employee")
    end

    it "can add an existing ticket to the employee using the ticket id" do
        visit "/employees/#{@employee_4.id}"

        expect(page).to_not have_content("blood in hallway")
        
        id = Ticket.last.id

        fill_in "Ticket Id", with: "#{id}"

        click_on "Add Ticket to Employee"

        expect(current_path).to eq("/employees/#{@employee_4.id}")

        expect(page).to have_content("blood in hallway")

    end

end