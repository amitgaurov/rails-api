class PatientsController < ApplicationController
	before_action :authenticate_patient
	include ActionController::MimeResponds
	 respond_to :json

   def index
    respond_to do |format|
    format.json { render json: {message: "patient not found!"}, status: :not_found }
   end
  end

	def show
    @patient = Patient.find_by(id: params[:id])
       if @patient.present?
        render json: @patient, status: 200
      else
         render json:{ status: 404, message: "patient not found!"}
       end
	end


  def new
    @patient = Patient.new
      respond_to do |format|
     format.json { render json: @patient}
  end
 end


 def create
	if params[:patient].present?
    @patient = Patient.new(sign_up_params)
    if @patient.save
         render json: @patient, status: 201, message: "patient created successfully!"
    else
        # format.html { render :new, notice: 'patient was not  created.' }
         render json: { errors: @patient.errors }, status: 422, message: "patient not created!"
     end
	 else
		 render json:{ status: 404, message: "wrong entry"}
	 end
  end


  def edit
    @patient= Patient.find_by(id: params[:id])
      respond_to do |format|
      format.json { render json: @patient}
    end
  end


  def update
		if params[:patient].present?
			@patient = Patient.find_by(id: params[:id])
		    if @patient.present?
		      if @patient.update_attributes(account_update_params)
		       # format.html { redirect_to root_path, notice: 'patient was successfully updated.' }
		      render json: @patient, status: 200,message: "patient updated  successfully!"
		    else
		     # format.html { render :edit, notice: 'patient was not udated.' }
		      render json: { errors: @patient.errors }, status: 422, message: "patient not updated!"
		    end
		   else
		   	render json:{ status: 404, message: "patient not found!"}
		  end
		else
				 render json:{ status: 404, message: "wrong entry"}
		end
 end


  def destroy
		if params[:patient].present?
		   @patient = Patient.find_by(id: params[:id])
		    respond_to do |format|
		     if @patient.present?
				     if @patient.delete
				      # format.html { redirect_to root_path, notice: 'patient was successfully destroyed.' }
				      format.json { render json: {status: 204, message: "patient deleted successfully!"} }
				    else
				      # format.html { redirect_to root_path, notice: 'Failed to delete.' }
				      format.json { render json: {status: 500, message: "patient not deleted!"} }
				    end
			  else
			   format.json { render json: {status: 500, message: "patient not found!"} }
		     end
		  end
		else
			render json:{ status: 404, message: "wrong entry"}
		end
 end

   def get_patient_appointments
     @patient=Patient.find_by(id: params[:id])
     if @patient.present?
       @appointments=@patient.appointments
	         if @appointments.present?
	         render json: @appointments, status: 200
	         else
	         render json:{ status: 404, message: "appointment not found"}
	         end
      else
       render json:{ status: 404, message: "patient not found"}
      end
 end

  private
   def sign_up_params
      params.require(:patient).permit(:name, :address, :age, :email, :password, :password_confirmation)
    end

    def account_update_params
       params.require(:patient).permit(:name, :address, :age, :email, :password)
    end

		  def authenticate_patient
		    if request.headers['Authorization'].present?
		      authenticate_or_request_with_http_token do |token|
		        begin
		          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

		          @current_patient_id = jwt_payload['id']
		        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
		          head :unauthorized
		        end
		      end
		    end
		  end

			def authenticate_patient!(options = {})
	     head :unauthorized unless signed_in?
	    end

	     def current_patient
	       @current_patient ||= super || Patient.find(@current_patient_id)
	     end

	     def signed_in?
	       @current_patient_id.present?
	     end


end
