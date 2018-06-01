# frozen_string_literal: true

class Doctors::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]


  # # GET /resource/sign_up
  #  #def new
  #   #  @doctor = Doctor.find(params[:id])
  #   #super
  #  #end

  # # POST /resource
  # def create
  #     @doctor = Doctor.new(doctor_params)
  #   if @doctor.save
  #     redirect_to @doctor
  #   else
  #     render 'new'
  #   end
  #   super
  #  end

  # # GET /resource/edit
  # def edit
  #  @doctor = Doctor.find(params[:id])
  #  super
  # end

  # # PUT /resource
  #   def update
  #      @doctor = User.find(params[:id])
  #   if @doctor.update_attributes(doctor_params)
  #      flash[:success] = "Profile updated"
  #     redirect_to @doctor
  #   else
  #     render 'edit'
  #   end
  #    super
  #   end

  # # DELETE /resource
  #  # def destroy
  #    #@doctor = Doctor.find(params[:id])
  #    #@doctor.destroy

  #    #redirect_to doctors_path
  #   #super
  #   #end

  # # GET /resource/cancel
  # # Forces the session data which is usually expired after sign
  # # in to be expired now. This is useful if the user wants to
  # # cancel oauth signing in/up in the middle of the process,
  # # removing all OAuth session data.
  # # def cancel
  # #   super
  # # end

   private

  #   def doctor_params
  #      params.require(:doctor).permit(:name, :specialist)
  #   end


    def sign_up_params
      params.require(:doctor).permit(:name, :specialist, :email, :password, :password_confirmation)
    end

    def account_update_params
       params.require(:doctor).permit(:name, :specialist, :email, :password, :password_confirmation, :current_password)
    end

  #   # def set_doctor
  #   #   @doctor = Doctor.find(params[:id])
  #   # end


  # # If you have extra params to permit, append them to the sanitizer.
  #  def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :specialist, :email, :password, :password_confirmation])
  #  end

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :specialist, :email, :password, :password_confirmation])
  # end

  # # The path used after sign up.
  # # def after_sign_up_path_for(resource)
  # #   super(resource)
  # # end

  # # The path used after sign up for inactive accounts.
  # # def after_inactive_sign_up_path_for(resource)
  # #   super(resource)
  # # end

end
