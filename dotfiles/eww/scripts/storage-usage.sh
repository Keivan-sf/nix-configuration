df -h / | awk '/\//{print $4}' | sed 's/.$//'
