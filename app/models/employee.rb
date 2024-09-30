class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def order_tickets_by_oldest
    tickets.order(age: :desc)
  end
end