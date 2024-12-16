#!/bin/bash

INSDIR="Brother"

# A) Print header message
echo "Brother Printer Driver Script MD Harrington London Kent DA6 8NP"
echo "https://github.com/markh2024?tab=repositories"
echo "Please wait ..."

# B) Pause for 5 seconds
sleep 5

# Insert new messages before opening the webpage
echo "About to open webpage for Brother Printer drivers. Go to the Utilities section."
echo 
echo "Select your Operating System version i.e., Linux, Windows, or Mac." 
echo 
echo "After downloading the Printer driver installer tool, please answer yes, no, or quit to the next question."

# 2: Check for Firefox and open the Brother drivers support URL
if command -v firefox &> /dev/null; then
    firefox https://www.brother.co.uk/support/drivers &
elif command -v xdg-open &> /dev/null; then
    xdg-open https://www.brother.co.uk/support/drivers &
else
    echo "Error: No compatible browser found. Please visit the URL manually."
    exit 1
fi

# Prompt user to confirm download completion
while [ ! -f "$HOME/Downloads/linux-brprinter-installer-2.2.4-1.gz" ]; do
    read -p "Has the download completed for the printer driver installation tool? (yes/quit): " DOWNLOAD_STATUS
    case "$DOWNLOAD_STATUS" in
        yes)
            break
            ;;
        quit)
            echo "Exiting script."
            exit 0
            ;;
        *)
            echo "Invalid input. Please enter yes or quit."
            ;;
    esac
done

# 3: Check if ~/installs directory exists, if not, create it
if [ ! -d "$HOME/$INSDIR" ]; then
    mkdir "$HOME/$INSDIR"
fi

# Move the driver file from Downloads to ~/installs
if [ -f "$HOME/Downloads/linux-brprinter-installer-2.2.4-1.gz" ]; then
    mv "$HOME/Downloads/linux-brprinter-installer-2.2.4-1.gz" "$HOME/$INSDIR/"
else
    echo "Error: linux-brprinter-installer-2.2.4-1.gz not found in Downloads."
    exit 1
fi

# 4: Test if gunzip is installed, if not, install it
if ! command -v gunzip &> /dev/null; then
    echo "Installing gzip utility..."
    sudo apt update && sudo apt install -y gzip
fi

# 5: Change to ~/installs directory
cd "$HOME/$INSDIR" || exit 1

# 6: Unzip the driver file
if [ -f "linux-brprinter-installer-2.2.4-1.gz" ]; then
    gunzip "linux-brprinter-installer-2.2.4-1.gz"
else
    echo "Error: linux-brprinter-installer-2.2.4-1.gz not found in installs."
    exit 1
fi

# 7: Remove the .gz file
rm -f "linux-brprinter-installer-2.2.4-1.gz"

# 8: Make the installer executable
chmod +x "linux-brprinter-installer-2.2.4-1"

# 9: Prompt user for printer model and run the installer
read -p "Enter your printer model (e.g., DCP-T220): " PRINTER_MODEL
sudo ./linux-brprinter-installer-2.2.4-1 "$PRINTER_MODEL"

# Leave the installs directory
cd ~ || exit 1

# Final message
clear
echo -e "Printer driver should now be installed on your machine\n"
echo -e "Thank You  MD Harrington  London Kent DA6 8NP"
echo -e "Current date and time: $(date)"
