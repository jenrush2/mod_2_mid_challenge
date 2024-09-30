require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it {should belong_to :department }
    it {should have_many :employee_tickets}
    it {should have_many(:tickets).through(:employee_tickets)}
  end

  describe "instance methods" do
    before :each do
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

    it "orders an employees tickets oldest to newest" do
      expect(@employee_4.order_tickets_by_oldest).to eq([@ticket_1, @ticket_3, @ticket_2])
    end
  end
end