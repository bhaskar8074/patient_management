require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'associations' do
    it { should belong_to(:provider) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:date_of_birth) }
  end

  describe 'scopes' do
    describe '.upcoming_appointments' do
      let!(:past_appointment) { create(:patient, next_appointment_date: 2.days.ago) }
      let!(:future_appointment) { create(:patient, next_appointment_date: 2.days.from_now) }
      let!(:far_future_appointment) { create(:patient, next_appointment_date: 5.days.from_now) }

      it 'returns patients with appointments within next 72 hours' do
        expect(Patient.upcoming_appointments).to include(future_appointment)
        expect(Patient.upcoming_appointments).not_to include(past_appointment)
        expect(Patient.upcoming_appointments).not_to include(far_future_appointment)
      end
    end
  end

  describe 'instance methods' do
    let(:patient) { create(:patient) }

    describe '#full_name' do
      it 'returns the combined first and last name' do
        expect(patient.full_name).to eq("#{patient.first_name} #{patient.last_name}")
      end
    end

    describe '#age' do
      it 'calculates age correctly' do
        patient = create(:patient, date_of_birth: 30.years.ago)
        expect(patient.age).to eq(30)
      end
    end
  end
end
