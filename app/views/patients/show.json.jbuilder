json.patient do |json|
  json.partial! 'patients/patient', patient: current_patient
end
