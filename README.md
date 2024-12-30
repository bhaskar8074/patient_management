# Patient Management System

## Overview
This application is a patient management system that allows healthcare providers to:
- Log in
- Create patients
- View all patients
- Filter patients based on relevance (appointments within 72 hours)
- Edit patient information

The application uses **Ruby on Rails** with PostgreSQL as the database. The focus is on functionality, ensuring ease of use for managing patient data.

---

## Prerequisites

Before setting up the application, ensure you have the following installed:
- [Ruby 3.2.0](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails 8.0.1](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Docker](https://www.docker.com/) (optional, for containerized setup)

---

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone <repository_url>
   cd <repository_name>
   ```

2. **Install Dependencies**:
   Run the following command to install the required gems:
   ```bash
   bundle install
   ```

3. **Setup Database**:
   Create and migrate the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Seed Sample Data** (optional):
   ```bash
   rails db:seed
   ```

5. **Run the Server**:
   Start the Rails server:
   ```bash
   rails server
   ```

6. **Access the Application**:
   Open your browser and navigate to: [http://localhost:3000](http://localhost:3000)

---

## Key Features

- **Authentication**: Uses `Devise` for user authentication.
- **Patient Management**:
  - Add, edit, and delete patients.
  - View all patients with pagination using `Kaminari`.
  - Search patients by name or email using `Ransack`.
  - View patients with appointments within 72 hours.
- **Error Handling**:
  - Unique email validation with error messages.
  - Friendly error messages for invalid actions.

---

## Running Tests

This application uses `RSpec` for testing. To run the test suite:
```bash
bundle exec rspec
```

---

## Docker Setup (Optional)

If you prefer to run the application in a containerized environment:

1. **Build the Docker Image**:
   ```bash
   docker-compose build
   ```

2. **Start the Application**:
   ```bash
   docker-compose up
   ```

3. **Access the Application**:
   Open [http://localhost:3000](http://localhost:3000).

---

## Notes

- **Appointment Logic**:
  - Patients with an appointment within 72 hours are marked as "soon".
- **Pagination**:
  - Configured using `Kaminari`, with a default limit of 10 patients per page.
- **Testing**:
  - Includes model, controller, and feature specs.

---

## Development Tools

- **Bootstrap 5.3**: For basic styling.
- **Debugging**: `web-console` and `debug` gems are included.
- **Code Quality**: Uses `Rubocop` and `Brakeman` for static analysis.

---

## Future Improvements

- Add more detailed tests for edge cases.
- Enhance UI/UX with advanced styling.
- Optimize query performance for large datasets.

---

## Contact

For any issues or inquiries, please reach out at: [bhaskar19191@gmail.com]

--- 

This README provides clear instructions and emphasizes functionality, as required in the problem description. Let me know if you’d like to refine any sections or add more details!