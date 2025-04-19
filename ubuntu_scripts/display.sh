if [ "$#" -ne 3 ]; then
echo "Usage: $0 <width> <height> <refresh_rate>"
exit 1
fi

# Assign input parameters
width="$1"
height="$2"
refresh="$3"

# Run cvt to generate modeline information
cvt_output=$(cvt "$width" "$height" "$refresh")

# Extract the line containing "Modeline"
modeline_full=$(echo "$cvt_output" | grep "Modeline")

# Remove the word "Modeline" to get only the parameters
modeline=$(echo "$modeline_full" | sed 's/Modeline //')

# Extract the mode name (first token, removing quotes)
mode_name=$(echo "$modeline" | awk '{print $1}' | sed 's/"//g')

# Get the remaining parameters (everything after the mode name)
mode_params=$(echo "$modeline" | cut -d' ' -f2-)

# Create the new mode with xrandr using the mode name and parameters
xrandr --newmode "$mode_name" $mode_params

# Add the new mode to the output "Virtual-1"
xrandr --addmode Virtual-1 "$mode_name"

# Set the new mode on "Virtual-1"
xrandr --output Virtual-1 --mode "$mode_name"
