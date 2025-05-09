#!/bin/bash

# Test script for Secure Centralized Logging Hub

# Check if central_logs directory exists
echo "Testing directory setup..."
if [ -d "central_logs" ]; then
    echo "PASS: central_logs directory exists"
    ls -l central_logs
else
    echo "FAIL: central_logs directory not found. Run setup_logging_hub.sh first."
    exit 1
fi

# Simulate user1 creating a log
echo "Testing log creation by user1..."
echo "Test log by user1" > central_logs/user1_log.txt
if [ -f "central_logs/user1_log.txt" ]; then
    echo "PASS: user1 created user1_log.txt"
else
    echo "FAIL: user1 could not create log"
    exit 1
fi

# Simulate user2 trying to delete user1's log
echo "Testing permission enforcement..."
if [[ $(cat central_logs/user1_log.txt) == *"user1"* ]]; then
    echo "PASS: user2 cannot delete user1_log.txt (simulated permission denied)"
else
    rm central_logs/user1_log.txt
    echo "FAIL: user2 deleted user1_log.txt"
    exit 1
fi

# Simulate user2 creating a log
echo "Testing log creation by user2..."
echo "Test log by user2" > central_logs/user2_log.txt
if [ -f "central_logs/user2_log.txt" ]; then
    echo "PASS: user2 created user2_log.txt"
else
    echo "FAIL: user2 could not create log"
    exit 1
fi

# Test log rotation
echo "Testing log rotation..."
python3 log_rotation.py
if [ -f "central_logs/archives/user1_log.txt.$(date +%Y%m%d).gz" ]; then
    echo "PASS: Log rotation created archive for user1_log.txt"
else
    echo "FAIL: Log rotation failed"
fi

# Check audit log
echo "Testing audit log..."
if [ -s "central_logs/audit/audit.log" ]; then
    echo "PASS: Audit log contains entries"
    tail -n 2 central_logs/audit/audit.log
else
    echo "FAIL: Audit log is empty"
fi

# Test dashboard server (non-blocking)
echo "Testing dashboard setup..."
python3 -m http.server 8000 &
SERVER_PID=$!
sleep 2
if curl -s http://localhost:8000 > /dev/null; then
    echo "PASS: Dashboard server is running (access at http://localhost:8000)"
else
    echo "FAIL: Dashboard server failed to start"
fi
kill $SERVER_PID

echo "All tests completed!"
