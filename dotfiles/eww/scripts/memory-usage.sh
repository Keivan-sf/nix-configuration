free -m | awk '/Mem/{free=$4; total=$2; used=$3; available=$7} END{print used}' | awk '{printf "%.1f", $1 / 1024}'
