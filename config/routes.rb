Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/departments", to: "departments#index"
  get "/employees/:employee_id", to: "employees#show"

  patch "/tickets/:employee_id", to: "tickets#update"

end
