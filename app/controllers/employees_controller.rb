class EmployeesController < ApplicationController
    def show
        @employee = Employee.find(params[:employee_id])
    end
end