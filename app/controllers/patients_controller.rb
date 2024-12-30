class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_provider.patients.ransack(params[:q])
    @patients = @q.result.page(params[:page]).per(5)
  end

  def upcoming
    @patients = current_provider.patients.upcoming_appointments.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @patient = current_provider.patients.build
  end

  def create
    @patient = current_provider.patients.build(patient_params)
    
    if @patient.save
      redirect_to patients_path, notice: 'Patient was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to patients_path, notice: 'Patient was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: 'Patient was successfully deleted.'
  end

  private

  def set_patient
    @patient = current_provider.patients.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to patients_path, alert: 'Patient not found.'
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :next_appointment_date, :date_of_birth)
  end
end
