#!/bin/bash

# Create directories
mkdir -p central_logs
mkdir -p central_logs/archives
mkdir -p central_logs/audit
mkdir -p central_logs/auth

# Create user database (simulating user1, user2, admin1)
cat <<EOF > central_logs/auth/users.json
{
    "user1": {"role": "user", "password": "password123"},
    "user2": {"role": "user", "password": "password123"},
    "admin1": {"role": "admin", "password": "password123"}
}
EOF

# Create audit log file
touch central_logs/audit/audit.log
chmod 644 central_logs/audit/audit.log

# Create sample log files for testing
echo "Test log by user1" > central_logs/user1_log.txt
echo "Test log by user2" > central_logs/user2_log.txt

echo "Logging hub setup complete!"
echo "Directory: central_logs"
echo "Simulated users: user1, user2, admin1"
echo "User database: central_logs/auth/users.json"
ls -l central_logs
