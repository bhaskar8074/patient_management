class Patient < ApplicationRecord
  belongs_to :provider
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, 
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
  
  scope :upcoming_appointments, -> { 
    where("next_appointment_date <= ? AND next_appointment_date >= ?", 
          72.hours.from_now, Time.current)
      .order(next_appointment_date: :asc)
  }
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    return nil unless date_of_birth
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - (date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["first_name", "last_name", "email", "next_appointment_date", "date_of_birth"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["provider"]
  end
end
