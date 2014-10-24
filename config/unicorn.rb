# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/soundbook/app"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/soundbook/app/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/soundbook/app/log/unicorn.log"
stdout_path "/home/soundbook/app/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.soundbook.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30