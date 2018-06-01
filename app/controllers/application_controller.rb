class ApplicationController < ActionController::API
 # before_action :authenticate_patient

include ActionController::HttpAuthentication::Basic::ControllerMethods
include ActionController::HttpAuthentication::Token::ControllerMethods

  respond_to :json


  private

#   def authenticate_patient
#     if request.headers['Authorization'].present?
#       authenticate_or_request_with_http_token do |token|
#         begin
#           jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
#
#           @current_patient_id = jwt_payload['id']
#         rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
#           head :unauthorized
#         end
#       end
#     end
#   end
#
#   def authenticate_patient!(options = {})
#     head :unauthorized unless signed_in?
#   end
#
#   def current_patient
#     @current_patient ||= super || Patient.find(@current_patient_id)
#   end
#
#   def signed_in?
#     @current_patient_id.present?
#   end
#
 end
