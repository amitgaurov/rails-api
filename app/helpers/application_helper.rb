module ApplicationHelper
def not_logged_in(&block)
  capture(&block) unless session[:patient_id]
end
end
