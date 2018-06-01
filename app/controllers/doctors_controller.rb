class DoctorsController < ApplicationController
  before_action :authenticate_doctor

  include ActionController::MimeResponds
   respond_to :json

  def index
    respond_to do |format|
    format.json { render json: {message: "doctor not found!"}, status: :not_found }
   end
  end

  def show
    @doctor = Doctor.find_by(id: params[:id])
       if @doctor.present?
        render json: @doctor, status: 200
      else
         render json:{ status: 404, message: "patient not found!"}
       end
  end


  def new
    @doctor = Doctor.new
      respond_to do |format|
     format.json { render json: @doctor}
  end
 end


 def create
  if params[:doctor].present?
   @doctor = Doctor.new(sign_up_params)
      if @doctor.save
         render json: @doctor, status: 201,message: "doctor created successfully!"
      else
        # format.html { render :new, notice: 'patient was not  created.' }
         render json: { errors: @doctor.errors }, status: 422,message: "doctor not created!"
      end
   else
      render json:{ status: 404, message: "wrong entry"}
    end
end


  def edit
    @doctor= Doctor.find_by(id: params[:id])
      respond_to do |format|
        format.json { render json: @Doctor}
      end
  end


  def update
   if params[:doctor].present?
        @doctor = Doctor.find_by(id: params[:id])
        if @doctor.present?
            if @doctor.update_attributes(account_update_params)
               # format.html { redirect_to root_path, notice: 'doctor was successfully updated.' }
              render json: @doctor, status: 200, message: "doctor update successfully!"
            else
             # format.html { render :edit, notice: 'doctor was not udated.' }
              render json: { errors: @doctor.errors }, status: 422, message: "doctor not updated!"
            end
        else
           render json:{ status: 404, message: "patient not found!"}
        end
    else
      render json:{ status: 404, message: "wrong entry"}
    end
 end


def destroy
  if params[:doctor].present?
      @doctor = Doctor.find_by(id: params[:id])
       respond_to do |format|
      if @doctor.present?
          if @doctor.delete
            # format.html { redirect_to root_path, notice: 'doctor was successfully destroyed.' }
            format.json { render json: {status: 204, message: "doctor deleted successfully!"} }
          else
            # format.html { redirect_to root_path, notice: 'Failed to delete.' }
            format.json { render json: {status: 500, message: "doctor not deleted!"} }
          end
       else
          format.json { render json: {status: 500, message: "doctor not found!"} }
      end
    end
  else
    render json:{ status: 404, message: "wrong entry"}
  end
 end

  def get_doctor_appointments
     @doctor=Doctor.find_by(id: params[:id])
    if @doctor.present?
       @appointments=@doctor.appointments
           if @appointments.present?
           render json: @appointments, status: 200
           else
           render json:{ status: 404, message: "appointment not found"}
           end
      else
       render json:{ status: 404, message: "doctor not found"}
      end
 end

private
    def sign_up_params
      params.require(:doctor).permit(:name, :specialist, :email, :password, :password_confirmation)
    end

    def account_update_params
       params.require(:doctor).permit(:name, :specialist, :email, :password)
    end


  def authenticate_doctor
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

          @current_doctor_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end
 end
