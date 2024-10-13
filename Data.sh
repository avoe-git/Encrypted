#!/bin/bash

# File where encrypted data will be stored
DATA_FILE="accounts.enc"

# Function to display the menu
show_menu() {
    echo "1. Add a new account"
    echo "2. View accounts"
    echo "3. Delete an account"
    echo "4. Exit"
}

# Function to add a new account
add_account() {
    echo "Enter your Valorant username:"
    read -r username
    echo "Enter your password:"
    read -sr password  # -s flag hides the input for security

    # Encrypting and saving the account details to the file
    echo "$username:$password" | openssl enc -aes-256-cbc -a -salt -pass pass:"$ENCRYPTION_KEY" >> "$DATA_FILE"
    echo "Account saved successfully!"
}

# Function to view accounts
view_accounts() {
    echo "Enter the decryption key:"
    read -sr decryption_key

    if [[ -f "$DATA_FILE" ]]; then
        echo "Stored accounts:"
        openssl enc -aes-256-cbc -d -a -pass pass:"$decryption_key" -in "$DATA_FILE" || echo "Invalid decryption key or corrupted data!"
    else
        echo "No accounts found."
    fi
}

# Function to delete an account
delete_account() {
    echo "Enter the decryption key:"
    read -sr decryption_key

    if [[ -f "$DATA_FILE" ]]; then
        decrypted_data=$(openssl enc -aes-256-cbc -d -a -pass pass:"$decryption_key" -in "$DATA_FILE" 2>/dev/null)

        if [[ $? -eq 0 ]]; then
            echo "Stored accounts:"
            echo "$decrypted_data"
            echo "Enter the username of the account you want to delete:"
            read -r del_username

            # Remove the account line from the decrypted data
            updated_data=$(echo "$decrypted_data" | grep -v "^$del_username:")

            # Re-encrypt and save the updated data
            echo "$updated_data" | openssl enc -aes-256-cbc -a -salt -pass pass:"$decryption_key" > "$DATA_FILE"
            echo "Account deleted successfully!"
        else
            echo "Invalid decryption key or corrupted data!"
        fi
    else
        echo "No accounts found."
    fi
}

# Main script loop
while true; do
    show_menu
    read -rp "Choose an option: " choice

    case $choice in
        1)
            echo "Enter a new encryption key to store the account:"
            read -sr ENCRYPTION_KEY
            add_account
            ;;
        2)
            view_accounts
            ;;
        3)
            delete_account
            ;;
        4)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
