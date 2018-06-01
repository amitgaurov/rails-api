class AppointmentsController < ApplicationController
  include ActionController::MimeResponds

  def index
  #  if current_patient.present?
  #       @appointments=current_patient.appointments
  #   elsif current_doctor.present?
  #       @appointments=current_doctor.appointments
  # end
  #   respond_to do |format|
  #   format.json { render json: @appointments}
  # end

    respond_to do |format|
    format.json { render json: {message: "appoinment not found!"}, status: :not_found }
   end
 end

def show
  @appointment = Appointment.find_by(id: params[:id])
  if @appointment.present?
       render json: @appointment, status: 200
  else
    render json:{ status: 404, message: "appointment not found!"}
   end
end


 def new
    @appointment = Appointment.new
      respond_to do |format|
  format.json { render json: @appointment }
 end
end


def create
  if params[:appoinment].present?
  @appointment = Appointment.new(appointment_params)
  if @appointment.save
       # format.html { redirect_to root_path, notice: 'appointment was successfully created.' }
      render json: @appointment, status: 201
  else
      # format.html { render :new, notice: 'appointment was not  created.' }
      render json: { errors: @appointment.errors }, status: 422
   end
 else
   render json:{ status: 404, message: "wrong entry"}
 end
end


def edit
     @appointment= Appointment.find_by(id: params[:id])
      respond_to do |format|
    format.json { render json: @appointment}
  end
end


  def update
    if params[:appoinment].present?
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment.present?
        if @appointment.update_attributes(appointment_update_params)
          # format.html { redirect_to root_path, notice: 'appointment was successfully updated.' }
            render json: @appointment, status: 200, message: "appointment update successfully!"
        else
         # format.html { render :edit, notice: 'appointment was not udated.' }
         render json: { errors: @appointment.errors }, status: 422, message: "appointment not updated"
        end
    else
       render json:{ status: 500, message: "appointment not found!"}
    end
  else
     render json:{ status: 404, message: "wrong entry"}
   end
end


  def destroy
    if params[:appoinment].present?
    @appointment = Appointment.find_by(id: params[:id])
    respond_to do |format|
    if @appointment.present?
        if @appointment.delete
          # format.html { redirect_to root_path, notice: 'appointment was successfully destroyed.' }
           format.json { render json: {status: 204, message: "appointment deleted successfully!"} }
        else
          # format.html { redirect_to root_path, notice: 'Failed to delete.' }
          format.json { render json: {status: 500, message: "appointment not deleted"} }
        end
    else
      format.json { render json: {status: 500, message: "appointment not found"} }
    end
   end
 else
    render json:{ status: 404, message: "wrong entry"}
  end
end

 private
  def appointment_params
    params.require(:appointment).permit(:timing, :doctor_id, :patient_id)
  end

  def appointment_update_params
   params.require(:appointment).permit(:timing)
 end

end
