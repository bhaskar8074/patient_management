require 'rails_helper'

RSpec.describe "Patients", type: :request do
  let(:provider) { create(:provider) }
  let(:patient) { create(:patient, provider: provider) }
  let(:valid_attributes) {
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      date_of_birth: '1990-01-01',
      next_appointment_date: '2024-12-31'
    }
  }
  let(:invalid_attributes) {
    {
      first_name: '',
      last_name: '',
      email: 'invalid-email'
    }
  }

  before do
    login_provider provider
  end

  describe "GET /patients" do
    it "displays the index page with patients" do
      patient # Create the patient
      get patients_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(patient.first_name)
    end
  end

  describe "GET /patients/upcoming" do
    it "shows upcoming appointments" do
      future_patient = create(:patient, 
        provider: provider, 
        first_name: "Test",
        last_name: "Patient",
        next_appointment_date: 1.day.from_now
      )
      past_patient = create(:patient, 
        provider: provider, 
        next_appointment_date: 1.day.ago
      )
      
      get upcoming_patients_path
      
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test")
      expect(response.body).to include("Patient")
      expect(response.body).to include(future_patient.next_appointment_date.strftime('%B %d, %Y'))
      expect(response.body).not_to include(past_patient.first_name)
    end
  end

  describe "GET /patients/new" do
    it "displays the new patient form" do
      get new_patient_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('New Patient')
    end
  end

  describe "POST /patients" do
    context "with valid parameters" do
      it "creates a new Patient" do
        expect {
          post patients_path, params: { patient: valid_attributes }
        }.to change(Patient, :count).by(1)
        expect(response).to redirect_to(patients_path)
        follow_redirect!
        expect(response.body).to include('Patient was successfully created.')
      end
    end

    context "with invalid parameters" do
      it "does not create a new Patient" do
        expect {
          post patients_path, params: { patient: invalid_attributes }
        }.to change(Patient, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
    end
  end

  describe "GET /patients/:id/edit" do
    it "displays the edit form" do
      get edit_patient_path(patient)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Edit Patient')
    end
  end

  describe "GET /patients/:id" do
    it "shows the patient" do
      get patient_path(patient)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(patient.first_name)
    end

    it "handles non-existent patients" do
      get patient_path(id: -1)
      expect(response).to redirect_to(patients_path)
      follow_redirect!
      expect(response.body).to include('Patient not found')
    end
  end

  describe "PATCH /patients/:id" do
    context "with valid parameters" do
      it "updates the patient" do
        patch patient_path(patient), params: { patient: { first_name: 'Updated' } }
        expect(response).to redirect_to(patients_path)
        follow_redirect!
        expect(response.body).to include('Patient was successfully updated')
        patient.reload
        expect(patient.first_name).to eq('Updated')
      end
    end

    context "with invalid parameters" do
      it "shows the edit form with errors" do
        patch patient_path(patient), params: { patient: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
    end
  end

  describe "DELETE /patients/:id" do
    it "deletes the patient" do
      patient_to_delete = create(:patient, provider: provider)
      expect {
        delete patient_path(patient_to_delete)
      }.to change(Patient, :count).by(-1)
      expect(response).to redirect_to(patients_path)
      follow_redirect!
      expect(response.body).to include('Patient was successfully deleted')
    end
  end
end