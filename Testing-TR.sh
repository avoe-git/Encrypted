#!/bin/bash
resize -s 40 100  # Set rows to 40 and columns to 100
# Set color variables
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Global variable for the typing message
typing_message="Update Notes: Special Encryptions added for RIOT Game Accounts!"

# Function to set the terminal size
set_terminal_size() {
    # Set the desired size (rows and columns)
    local rows=40
    local cols=100
    printf '\e[8;%d;%dt' "$rows" "$cols"
}
# Function to display the ASCII art header
print_header() {
    echo -e "${GREEN}"
    echo "__| |__________________________________________________________________| |__"
    echo "__   __________________________________________________________________   __"
    echo "  | |                                                                  | |  "
    echo "  | | _____ _   _  ____ ______   ______ _____ _____ ____   ____  _   _ | |  "
    echo "  | || ____| \ | |/ ___|  _ \ \ / /  _ \_   _| ____|  _ \ / ___|| | | || |  "
    echo "  | ||  _| |  \| | |   | |_) \ V /| |_) || | |  _| | | | |\___ \| |_| || |  "
    echo "  | || |___| |\  | |___|  _ < | | |  __/ | | | |___| |_| | ___) |  _  || |  "
    echo "  | ||_____|_| \_|\____|_| \_\|_| |_|    |_| |_____|____(_)____/|_| |_|| |  "
    echo "  | || |__  _   _    __ ___   _____   ___   __| | _____   __           | |  "
    echo "  | || '_ \\| | | |  / _\` . \\ / / _ \\ / _ \\ / _\` |/ _ \\ \\ / /           | | "
    echo "  | || |_) | |_| | | (_| |\ V / (_) |  __/| (_| |  __/\ V /            | |  "
    echo "  | ||_.__/ \__, |  \__,_| \_/ \___/ \___(_)__,_|\___| \_/             | |  "
    echo "  | |       |___/                                                      | |  "
    echo "__| |__________________________________________________________________| |__"
    echo "__   __________________________________________________________________   __"
    echo -e "${NC}"
    echo -e "\e[1m                  ENCRYPTED.SH by avoe - Simple Key Manager\e[0m"
    echo -e "${GREEN}"
    echo "============================================================================"
    echo -e "${NC}"
}

# Function to simulate typing (infinite loop)
infinite_typing() {
    local message_length=${#typing_message}
    local current_pos=0

    while true; do
        # Move the cursor to a fixed position to update the text in place
        echo -ne "\033[2;4H"  # Move to a specific position in the terminal window

        # Clear the previous line content by printing spaces (to handle shorter text cases)
        echo -ne "                                        \r" 

        # Display the typing message in a single line with the animation
        echo -ne "${typing_message:current_pos} ${typing_message:0:current_pos}"

        current_pos=$(( (current_pos + 1) % message_length ))  # Increment and wrap around
        sleep 0.1  # Adjust delay for smoother typing animation
    done
}




const_menu_up() {
    echo "_____________________________________"
    echo "| 0 | Exit Script                   |"
    echo "| 1 | Create new encryption         |"
    echo "| 2 | Log in to existing encryption |"
    echo "| 3 | View existing encryptions     |"
}
const_menu_bottom() {
    echo "_____________________________________"
    echo "| 7 | Help                          |"
    echo "| 8 | Troubleshoot                  |"
    echo "| 9 | Encryption settings           |"
    echo "_____________________________________"
}
state_keypress_main() {
    read -n 1 -s key  # Wait for the user to press a key (without showing it)
    echo

    if [[ $key == "0" ]]; then
        echo -e "\nExiting the script. Goodbye!"
        exit 0
    fi
}
set_terminal_size
# Start the typing animation in the background
infinite_typing &

# Main loop
while true; do 
    clear
    print_header
    const_menu_up
    const_menu_bottom
    state_keypress_main
done
