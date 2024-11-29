# Boilerplate V2 - Location Contribution System

A full-stack app for identifying transaction locations using Google Maps API and tracking user contributions.

## Prerequisites

- Docker installed
- Google Places API Key

## Running the Project

1. Clone the repository:
   ```
   git clone https://github.com/bakill3/symfony-boilerplate-exercise.git
   cd boilerplate-v2
   ```
2. Start the application:
   ```
   docker-compose up -d --build
   ```
3. Start the application:
   - Go to http://phpmyadmin.boilerplatev2.localhost
   - Select 'api' database and run your SQL script (you can find api.sql on the root folder of symfony-boilerplate)
4. Replace Google Places API Key:
   - Open /apps/front/nuxt.config.ts
   - Replace the key on line 42
5. Access the app:
   - Frontend: http://boilerplatev2.localhost
   - Database: http://phpmyadmin.boilerplatev2.localhost
   - Test Login:
    - gabriel@gmail.com | gabriel

## Features

### Login
- A login page with email and password fields.
- Proper session handling to ensure secure access.

### Transactions Page
- Displays a list of transactions specific to the logged-in user.
- Each transaction shows:
  - Date/Time
  - Amount
  - Payment Label
  - Location
- For transactions without a location:
  - A button allows users to identify the location via a modal.
  - The modal:
    - Shows a map centered on the GPS coordinates from the database.
    - Fetches nearby locations using the Google Places API.
    - Allows the user to select a location, which is then saved to the database (along with latitude and longitude).

### Dashboard (Optional)
- Displays user contribution statistics:
  - **User Score**: 
    - 5 points per identification for the first 10 transactions.
    - 3 points for the next 20 transactions.
    - 1 point for each subsequent transaction.
    - 20 bonus points for identifying a unique payment label not previously identified by another user.
  - **Pending Validations**:
    - Shows the number of transactions where the user has not yet identified a location.

### Users Page (Optional) - Half Complete 
- Accessible only to administrators.
- Displays a list of users with the following details:
  - Email
  - First Name
  - Last Name
  - User Role

## Challenges Faced

- **Installing Ubuntu on Windows**: Due to Docker-related issues on a Windows machine, it was necessary to install Ubuntu to ensure the proper functioning of the setup.
- **Google Places API Key Management**: Bugs encountered when using `.env` to load the Google Places API key forced the key to be hardcoded directly in `nuxt.config.ts` on line 42.
- **Real-Time Updates in Transactions**: Implementing real-time updates in the frontend after saving location data required careful adjustments to state management.
- **Accurate Score Calculation**: Debugging the logic to calculate user scores dynamically based on transaction data posed challenges in ensuring it met all criteria.
- **Environment Variables**: Issues with loading environment variables correctly in the frontend required multiple iterations and workarounds to resolve.

