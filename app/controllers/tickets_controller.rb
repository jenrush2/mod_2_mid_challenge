class TicketsController < ApplicationController
    def update
        employee = Employee.find(params[:employee_id])
        ticket = Ticket.find(params[:ticket_id])
        employee.tickets << ticket
        show_page = "/employees/#{params[:employee_id]}"
        redirect_to show_page
    end
end