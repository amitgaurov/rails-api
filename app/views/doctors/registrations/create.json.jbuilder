json.doctor do |json|
  json.partial! 'doctors/doctor', doctor: current_doctor
end
