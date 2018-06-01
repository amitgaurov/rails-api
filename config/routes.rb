Rails.application.routes.draw do

devise_for :patients, controllers: { :registrations => 'patients/registrations',  :sessions => 'patients/sessions' },
                       path_names: { sign_in: :login }
scope :api  do
  resources :patients
end

devise_for :doctors,controllers: {:registrations => 'doctors/registrations', :sessions => 'doctors/sessions' },
                       path_names: { sign_in: :login }
scope :api  do
  resources :doctors
end
scope :api  do
resources :appointments
end

root to: "clinic#index"

get '/doctors/get_doctor_appointments/:id' => 'doctors#get_doctor_appointments'

get '/patients/get_patient_appointments/:id' => 'patients#get_patient_appointments'


 end
