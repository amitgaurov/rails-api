# frozen_string_literal: true

class Patients::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json
  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create
    @patient = Patient.find_by_email(sign_in_params[:email])

    if @patient && @patient.valid_password?(sign_in_params[:password])
      @current_patient = @patient
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  # POST /resource/sign_in
  # def create
  #   @patient=picture.all
  #   super
  # end

  # # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

 protected


 # def after_sign_in_path_for(resource)
 #    edit_patient_registration_path(current_patient) #your path
 # end
 #
 # def after_sign_out_path_for(resource_or_scope)
 #     root_path
 # end
 #
  def sign_in_params
      params.require(:patient).permit(:name,:age,:address, :email, :password, :password_confirmation)
    end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
