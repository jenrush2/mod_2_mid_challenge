class EmployeesController < ApplicationController
    def show
        @employee = Employee.find(params[:employee_id])
        @ordered_tickets = @employee.order_tickets_by_oldest
    end
end