#!/bin/bash

# File where encrypted data will be stored
DATA_FILE="accounts.enc"

# Function to display the menu
show_menu() {
    echo "1. Add a new account"
    echo "2. View accounts"
    echo "3. Exit"
}

# Function to add a new account
add_account() {
    echo "Enter your Valorant username:"
    read -r username
    echo "Enter your password:"
    read -sr password  # -s flag hides the input for security

    # Encrypting and saving the account details to the file
    echo "$username:$password" | openssl enc -aes-256-cbc -a -salt -pass pass:your_secret_key >> "$DATA_FILE"
    echo "Account saved successfully!"
}

# Main script loop
while true; do
    show_menu
    read -rp "Choose an option: " choice

    case $choice in
        1)
            add_account
            ;;
        2)
            echo "Feature not yet implemented."
            ;;
        3)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
