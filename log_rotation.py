import os
import datetime
import shutil
import gzip
import json
import logging

# Configure audit logging
logging.basicConfig(filename='central_logs/audit/audit.log', level=logging.INFO,
                    format='%(asctime)s - %(message)s')

def check_permission(filename, username):
    # Simulate permission check (in Replit, no real user ownership)
    return username in filename  # Allow only if username is in filename

def rotate_logs():
    log_dir = 'central_logs'
    archive_dir = 'central_logs/archives'
    today = datetime.datetime.now().strftime('%Y%m%d')

    for filename in os.listdir(log_dir):
        if filename.endswith('.txt'):
            src_path = os.path.join(log_dir, filename)
            archive_path = os.path.join(archive_dir, f"{filename}.{today}.gz")
            
            # Simulate user1 rotating their own log
            if check_permission(filename, 'user1'):
                with open(src_path, 'rb') as f_in:
                    with gzip.open(archive_path, 'wb') as f_out:
                        shutil.copyfileobj(f_in, f_out)
                os.remove(src_path)
                logging.info(f"Rotated log {filename} to {archive_path}")
            else:
                logging.warning(f"Permission denied for rotating {filename}")

def authenticate_user(username, password):
    with open('central_logs/auth/users.json', 'r') as f:
        users = json.load(f)
    if username in users and users[username]['password'] == password:
        logging.info(f"User {username} authenticated successfully")
        return users[username]['role']
    logging.warning(f"Failed authentication attempt for {username}")
    return None

if __name__ == "__main__":
    # Test authentication
    print(authenticate_user('user1', 'password123'))  # Should print 'user'
    print(authenticate_user('user1', 'wrongpass'))    # Should print None
    # Run log rotation
    rotate_logs()
