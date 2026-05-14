# Medical Appointment Scheduling System

## Overview
The Medical Appointment Scheduling System is a comprehensive web-based application designed to streamline healthcare facility operations. Built using Java Servlets, JSP, and a file-based data management system, this platform handles everything from patient registrations to billing and medical records.

## System Architecture
This project is built using a clear, modular MVC (Model-View-Controller) architecture:
- **Frontend:** JSP, HTML, CSS
- **Backend:** Java EE (Servlets, Models, Controllers)
- **Server:** Embedded Jetty Server (via Maven)
- **Data Persistence:** File-based data storage (`/data` directory)

## Modules & Team Contributions
This project was developed collaboratively by a 6-member team, with each member taking ownership of a specific module:

1. **Patient Management** (Thissari) - Patient registration, profiles, and dashboard.
2. **Doctor Directory** (Ranesh) - Doctor profiles, specializations, and availability.
3. **Appointment Scheduling** (Abdul) - Booking, updating, and tracking appointments.
4. **Medical Records** (Kavishka) - Diagnosis reports, prescriptions, and historical data.
5. **Billing & Payments** (Rohan) - Invoice generation, insurance, and direct payments.
6. **Admin & Authentication** (Navodya) - System security, login routing, and role-based access control.

## Setup & Installation
1. Clone the repository to your local machine.
2. Ensure you have Java 11+ and Maven installed.
3. Run the project using the Jetty Maven Plugin:
   ```bash
   mvn jetty:run
   ```
4. Access the application via `http://localhost:8080/index.jsp`

## Academic Integrity
This project was developed as a final submission for our university curriculum, strictly adhering to OOP principles and standard Java formatting guidelines.
