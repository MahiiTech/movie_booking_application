# 🎬 Movie Booking App

A Flutter application for browsing movies and booking seats with an interactive seat selection system.

---

## 📱 Application Details
- **Application Name:** Movie Booking App
- **Framework:** Flutter
- **State Management:** Provider
- **Platform:** Android / iOS

---

## 🛠️ Project Setup

This project is built using the following environment:

Flutter 3.27.1 • channel stable • https://github.com/flutter/flutter.git

Framework • revision 17025dd882 (9 months ago) • 2024-12-17 03:23:09 +0900
Engine • revision cb4b5fff73
Tools • Dart 3.6.0 • DevTools 2.40.2


### 🔧 Steps to Run the Project
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/movie_booking_app.git

### Seat Booking / Selection Logic

The seat booking feature is implemented using a grid-based system.
Here’s the main logic behind it:

#### 1. Seat Grid Layout

The seating arrangement is represented as a grid with a fixed number of rows and columns.

Each seat has a unique seat ID based on its row and column (e.g., "2-5" means row 2, column 5).

#### 2. Booked Seats

Some seats are pre-defined as already booked and cannot be selected.

Booked seats are displayed in grey.

#### 3. Seat Selection

Users can tap on available seats to select them.

Selected seats are highlighted in green.

If the user taps again, the seat will be deselected.

#### 4. State Management

The app uses Provider to manage seat selection state.

The SeatSelectionProvider holds:

#### 5. Booked seats list

Currently selected seats set

Whenever a seat is toggled, the UI updates automatically.

#### 6. Checkout Flow

Once seats are selected, the user can proceed to checkout.

The app navigates to a summary screen where the selected seats and movie details are displayed.


