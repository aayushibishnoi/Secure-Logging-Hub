# Secure Centralized Logging Hub with Web Dashboard

A secure logging system for multiple users, featuring a centralized log directory, automated log rotation, and a React-based web dashboard.

## Features
- **Centralized Logs**: Stores logs in `central_logs` with simulated permissions to prevent unauthorized modifications.
- **Log Rotation**: Python script archives logs daily to manage disk space.
- **Web Dashboard**: React + Tailwind CSS interface for admins to view and search logs.
- **Audit Trail**: Tracks user actions for accountability.

## Tech Stack
- Bash (directory setup)
- Python (log rotation, authentication)
- React + Tailwind CSS (dashboard)

## Setup
1. Run `setup_logging_hub.sh` to create directories and user database.
2. Schedule `log_rotation.py` for daily execution (e.g., via cron).
3. Host `index.html` on a web server (e.g., `python3 -m http.server 8000`).
4. Access the dashboard at `http://localhost:8000`.

## Usage
- Users (`user1`, `user2`) write logs to `central_logs`.
- Admins (`admin1`) view logs via the dashboard.
- Password: `password123` (for demo).

