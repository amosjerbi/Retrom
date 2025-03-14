#!/bin/bash

# Set variables
CURRENT_PLATFORM=""
DEFAULT_ROMS_BASE_DIR="$HOME/smb-mount/games-roms/"
ROMS_BASE_DIR="$DEFAULT_ROMS_BASE_DIR"

# Check for command line argument for ROMS_BASE_DIR
if [ -n "$1" ]; then
    ROMS_BASE_DIR="$1"
fi

NES_DIR="$ROMS_BASE_DIR/nes"
SNES_DIR="$ROMS_BASE_DIR/snes"
GENESIS_DIR="$ROMS_BASE_DIR/genesis"
GB_DIR="$ROMS_BASE_DIR/gb"
GBA_DIR="$ROMS_BASE_DIR/gba"
GBC_DIR="$ROMS_BASE_DIR/gbc"
GAMEGEAR_DIR="$ROMS_BASE_DIR/gamegear"
NGP_DIR="$ROMS_BASE_DIR/ngp"
SMS_DIR="$ROMS_BASE_DIR/mastersystem"
SEGACD_DIR="$ROMS_BASE_DIR/segacd"
SEGA32X_DIR="$ROMS_BASE_DIR/sega32x"
SATURN_DIR="$ROMS_BASE_DIR/saturn"
TG16_DIR="$ROMS_BASE_DIR/tg16"
TGCD_DIR="$ROMS_BASE_DIR/tgcd"
PS1_DIR="$ROMS_BASE_DIR/ps1"
PS2_DIR="$ROMS_BASE_DIR/ps2"
N64_DIR="$ROMS_BASE_DIR/n64"
DREAMCAST_DIR="$ROMS_BASE_DIR/dreamcast"
LYNX_DIR="$ROMS_BASE_DIR/lynx"
TEMP_FILE="/tmp/rom_list.txt"
SMB_MOUNT_DIR="$HOME/smb-mount/Volumes"

# Create SMB mount directory if it doesn't exist
mkdir -p "$SMB_MOUNT_DIR"

# We'll focus on using the $HOME/smb-mount path for all mounts

# Note: We'll use user's home directory for all mounts to avoid requiring admin privileges

# Define function to get archive URL for a platform
get_archive_url() {
    local platform="$1"
    
    case "$platform" in
        "nes")
            echo "PUT_LINK_HERE"
            ;;
        "snes")
            echo "PUT_LINK_HERE"
            ;;
        "genesis")
            echo "PUT_LINK_HERE"
            ;;
        "gb")
            echo "PUT_LINK_HERE"
            ;;
        "gba")
            echo "PUT_LINK_HERE"
            ;;
        "gbc")
            echo "PUT_LINK_HERE"
            ;;
        "gg")
            echo "PUT_LINK_HERE"
            ;;
        "ngp")
            echo "PUT_LINK_HERE"
            ;;
        "sms")
            echo "PUT_LINK_HERE"
            ;;
        "segacd")
            echo "PUT_LINK_HERE"
            ;;
        "sega32x")
            echo "PUT_LINK_HERE"
            ;;
        "saturn")
            echo "PUT_LINK_HERE"
            ;;
        "tg16")
            echo "PUT_LINK_HERE"
            ;;
        "tgcd")
            echo "PUT_LINK_HERE"
            ;;
        "ps1")
            echo "PUT_LINK_HERE"
            ;;
        "ps2")
            echo "PUT_LINK_HERE"
            ;;
        "n64")
            echo "PUT_LINK_HERE"
            ;;
        "dreamcast")
            echo "PUT_LINK_HERE"
            ;;
        "lynx")
            echo "PUT_LINK_HERE"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Function to get platform directory
get_platform_dir() {
    local platform="$1"
    
    case "$platform" in
        "nes")
            echo "$NES_DIR"
            ;;
        "snes")
            echo "$SNES_DIR"
            ;;
        "genesis")
            echo "$GENESIS_DIR"
            ;;
        "gb")
            echo "$GB_DIR"
            ;;
        "gba")
            echo "$GBA_DIR"
            ;;
        "gbc")
            echo "$GBC_DIR"
            ;;
        "gg")
            echo "$GAMEGEAR_DIR"
            ;;
        "ngp")
            echo "$NGP_DIR"
            ;;
        "sms")
            echo "$SMS_DIR"
            ;;
        "segacd")
            echo "$SEGACD_DIR"
            ;;
        "sega32x")
            echo "$SEGA32X_DIR"
            ;;
        "saturn")
            echo "$SATURN_DIR"
            ;;
        "tg16")
            echo "$TG16_DIR"
            ;;
        "tgcd")
            echo "$TGCD_DIR"
            ;;
        "ps1")
            echo "$PS1_DIR"
            ;;
        "ps2")
            echo "$PS2_DIR"
            ;;
        "n64")
            echo "$N64_DIR"
            ;;
        "dreamcast")
            echo "$DREAMCAST_DIR"
            ;;
        "lynx")
            echo "$LYNX_DIR"
            ;;
        *)
            echo "$ROMS_BASE_DIR/$platform"
            ;;
    esac
}

# Function to decode URL-encoded strings
urldecode() {
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

# Function to convert to uppercase
to_uppercase() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

# Function to open the ROMs folder
open_roms_folder() {
    # Get the platform subdirectory name
    local platform_subdir=""
    case "$CURRENT_PLATFORM" in
        "nes") platform_subdir="nes" ;;
        "snes") platform_subdir="snes" ;;
        "genesis") platform_subdir="genesis" ;;
        "gb") platform_subdir="gb" ;;
        "gba") platform_subdir="gba" ;;
        "gbc") platform_subdir="gbc" ;;
        "gg") platform_subdir="gamegear" ;;
        "ngp") platform_subdir="ngp" ;;
        "sms") platform_subdir="mastersystem" ;;
        "segacd") platform_subdir="segacd" ;;
        "sega32x") platform_subdir="sega32x" ;;
        "saturn") platform_subdir="saturn" ;;
        "tg16") platform_subdir="tg16" ;;
        "tgcd") platform_subdir="tgcd" ;;
        "ps1") platform_subdir="ps1" ;;
        "ps2") platform_subdir="ps2" ;;
        "n64") platform_subdir="n64" ;;
        "dreamcast") platform_subdir="dreamcast" ;;
        "lynx") platform_subdir="lynx" ;;
        *) platform_subdir="$CURRENT_PLATFORM" ;;
    esac
    
    # Try all possible locations for the SMB share
    local possible_paths=(
        "/Volumes/games-roms/$platform_subdir"                # Standard macOS mount
        "$SMB_MOUNT_DIR/games-roms/$platform_subdir"       # Custom mount in home directory
        "$HOME/smb-mount/games-roms/$platform_subdir"      # Alternative mount path
        "/Volumes/GAMES-ROMS/$platform_subdir"              # Uppercase variant
        "/Volumes/ROMS/$platform_subdir"                    # Common alternative name
        "/Volumes/Games/$platform_subdir"                   # Another common name
    )
    
    local platform_dir=""
    local found=false
    
    # Check each possible path
    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ]; then
            platform_dir="$path"
            found=true
            echo "Found ROMs directory at: $platform_dir"
            break
        fi
    done
    
    # If no directory was found, try to use Finder to open the SMB share directly
    if [ "$found" = false ]; then
        echo "No ROMs directory found. Attempting to open SMB share directly."
        
        # On macOS, try to open the SMB share using Finder
        if [ "$(uname)" = "Darwin" ]; then
            # Try to open the SMB share in Finder
            echo "Opening SMB share in Finder..."
            osascript -e 'tell application "Finder" to open location "smb://guest@192.168.0.132/games-roms/'"$platform_subdir"'"' 2>/dev/null
            
            if [ $? -eq 0 ]; then
                echo "Opened SMB share directly in Finder"
                return 0
            else
                echo "Failed to open SMB share directly. Trying alternative method..."
                open "smb://guest@192.168.0.132/games-roms/$platform_subdir" 2>/dev/null || \
                open "smb://guest@192.168.0.132/games-roms" 2>/dev/null || \
                open "smb://192.168.0.132/games-roms" 2>/dev/null
                return 0
            fi
        else
            # For Linux or other systems
            echo "Direct SMB opening not supported on this OS. Trying to create local directory..."
            platform_dir="$HOME/smb-mount/games-roms/$platform_subdir"
            mkdir -p "$platform_dir" 2>/dev/null
        fi
    fi
    
    echo "Opening ROMs folder for platform: $(to_uppercase $CURRENT_PLATFORM)"
    echo "Directory: $platform_dir"
    
    # Open the directory based on the OS
    case "$(uname)" in
        "Darwin") # macOS
            open "$platform_dir"
            ;;
        "Linux")
            if command -v xdg-open > /dev/null; then
                xdg-open "$platform_dir"
            else
                echo "Cannot open directory. xdg-open not found."
                return 1
            fi
            ;;
        "MINGW"*|"MSYS"*|"CYGWIN"*) # Windows
            explorer "$platform_dir"
            ;;
        *)
            echo "Unsupported operating system for opening directories."
            return 1
            ;;
    esac
}

# Function to handle arrow key navigation and numeric selection
menu_select() {
    local options=("$@")
    local num_options=${#options[@]}
    local selected=0
    local key

    # Save current cursor position and hide it
    tput sc
    tput civis

    # Function to draw menu
    draw_menu() {
        # Restore cursor position and clear below
        tput rc
        tput ed
        
        for i in $(seq 0 $((num_options-1))); do
            if [ $i -eq $selected ]; then
                printf "\033[7m> %2d. %s\033[0m\n" $((i+1)) "${options[$i]}"  # Highlighted with number
            else
                printf "  %2d. %s\n" $((i+1)) "${options[$i]}"  # With number
            fi
        done
    }

    # Draw initial menu
    draw_menu

    # Handle keypresses
    while true; do
        read -rsn1 key

        # Check if key is a number
        if [[ $key =~ [0-9] ]]; then
            # Start collecting digits for multi-digit numbers
            local number=$key
            local timeout=0.5  # Timeout in seconds
            
            # Set up a timeout for reading additional digits
            read -rsn1 -t $timeout next_key
            while [[ $? -eq 0 && $next_key =~ [0-9] ]]; do
                number="${number}${next_key}"
                read -rsn1 -t $timeout next_key
            done
            
            # Convert to integer and check if it's valid
            number=$((10#$number))  # Force base 10 interpretation
            
            if [ $number -ge 1 ] && [ $number -le $num_options ]; then
                tput cnorm  # Show cursor
                echo
                return $number
            fi
            
            # If invalid number, just redraw the menu
            draw_menu
            continue
        fi

        case "$key" in
            $'\x1b')  # ESC sequence
                read -rsn2 key
                case "$key" in
                    '[A')  # Up arrow
                        if [ $selected -gt 0 ]; then
                            selected=$((selected-1))
                            draw_menu
                        fi
                        ;;
                    '[B')  # Down arrow
                        if [ $selected -lt $((num_options-1)) ]; then
                            selected=$((selected+1))
                            draw_menu
                        fi
                        ;;
                esac
                ;;
            '')  # Enter key
                tput cnorm  # Show cursor
                echo
                return $((selected + 1))
                ;;
        esac
    done
}

# Function to select a platform
select_platform() {
    clear
    echo "Select a platform (use ↑↓ arrows, press Enter to select):"
    echo "-----------------------------------------------------"
    
    local platforms=(
        "NES (Nintendo Entertainment System)"
        "SNES (Super Nintendo)"
        "GB (Game Boy)"
        "GBA (Game Boy Advance)"
        "GBC (Game Boy Color)"
        "SMS (Sega Master System)"
        "Genesis (Sega Genesis)"
        "SEGACD (Sega CD)"
        "SEGA32X (Sega 32X)"
        "SATURN (Sega Saturn)"
        "GG (Sega Game Gear)"
        "NGP (Neo Geo Pocket)"
        "TG16 (TurboGrafx-16)"
        "TGCD (TurboGrafx-CD)"
        "PS1 (PlayStation)"
        "PS2 (PlayStation 2)"
        "N64 (Nintendo 64)"
        "DREAMCAST (Sega Dreamcast)"
        "LYNX (Atari Lynx)"
    )
    
    menu_select "${platforms[@]}"
    platform_choice=$?
    
    case $platform_choice in
        1)
            CURRENT_PLATFORM="nes"
            echo "Selected platform: NES"
            ;;
        2)
            CURRENT_PLATFORM="snes"
            echo "Selected platform: SNES"
            ;;
        3)
            CURRENT_PLATFORM="gb"
            echo "Selected platform: Game Boy"
            ;;
        4)
            CURRENT_PLATFORM="gba"
            echo "Selected platform: Game Boy Advance"
            ;;
        5)
            CURRENT_PLATFORM="gbc"
            echo "Selected platform: Game Boy Color"
            ;;
        6)
            CURRENT_PLATFORM="sms"
            echo "Selected platform: Sega Master System"
            ;;
        7)
            CURRENT_PLATFORM="genesis"
            echo "Selected platform: Genesis"
            ;;
        8)
            CURRENT_PLATFORM="segacd"
            echo "Selected platform: Sega CD"
            ;;
        9)
            CURRENT_PLATFORM="sega32x"
            echo "Selected platform: Sega 32X"
            ;;
        10)
            CURRENT_PLATFORM="saturn"
            echo "Selected platform: Sega Saturn"
            ;;
        11)
            CURRENT_PLATFORM="gg"
            echo "Selected platform: Sega Game Gear"
            ;;
        12)
            CURRENT_PLATFORM="ngp"
            echo "Selected platform: Neo Geo Pocket"
            ;;
        13)
            CURRENT_PLATFORM="tg16"
            echo "Selected platform: TurboGrafx-16"
            ;;
        14)
            CURRENT_PLATFORM="tgcd"
            echo "Selected platform: TurboGrafx-CD"
            ;;
        15)
            CURRENT_PLATFORM="ps1"
            echo "Selected platform: PlayStation"
            ;;
        16)
            CURRENT_PLATFORM="ps2"
            echo "Selected platform: PlayStation 2"
            ;;
        17)
            CURRENT_PLATFORM="n64"
            echo "Selected platform: Nintendo 64"
            ;;
        18)
            CURRENT_PLATFORM="dreamcast"
            echo "Selected platform: Sega Dreamcast"
            ;;
        19)
            CURRENT_PLATFORM="lynx"
            echo "Selected platform: Atari Lynx"
            ;;
        *)
            echo "Invalid choice. Using default platform: Genesis"
            CURRENT_PLATFORM="genesis"
            ;;
    esac
}

# Function to detect and connect to SMB
detect_and_connect_smb() {
    clear
    echo "===== SMB Detection and Connection ====="
    
    # Create a menu with connection options
    local connection_options=(
        "MacOS - Scan & mount SMB"
        "Windows - Scan & mount SMB"
        "Linux - Scan & mount SMB"
        "Enter SMB address manually"
        "Return to main menu"
    )
    
    echo "Select a connection option:"
    echo "-----------------------------------------------------"
    menu_select "${connection_options[@]}"
    local connection_choice=$?
    
    # Handle the selected option
    case $connection_choice in
        1|2|3) # Scan network (MacOS, Windows, or Linux)
            clear
            local os_type=""
            if [ "$connection_choice" -eq 1 ]; then
                echo "===== Scanning Network for MacOS SMB Servers ====="
                os_type="MacOS"
            elif [ "$connection_choice" -eq 2 ]; then
                echo "===== Scanning Network for Windows SMB Servers ====="
                os_type="Windows"
            elif [ "$connection_choice" -eq 3 ]; then
                echo "===== Scanning Network for Linux SMB Servers ====="
                os_type="Linux"
            fi
            
            # Create temporary files for storing SMB shares
            local smb_list_file=$(mktemp)
            
            # Get the local IP and subnet
            local ip_info=$(ifconfig | grep "inet " | grep -v 127.0.0.1)
            local ip_addr=$(echo "$ip_info" | awk '{print $2}' | head -1)
            local subnet=$(echo "$ip_addr" | cut -d. -f1-3)
            
            echo "Your IP address: $ip_addr"
            echo "Scanning subnet: $subnet.x"
            echo "Looking for $os_type SMB servers..."
            
            # Add known SMB server (always include this)
            echo "192.168.0.132" > "$smb_list_file"
            
            # Quick scan of common IP addresses
            echo "Scanning common IP addresses..."
            
            # Common IP ranges for routers and servers
            common_ips=("1" "100" "101" "102" "103" "104" "105" "110" "120" "130" "132" "150" "200" "201" "202" "254")
            
            # Scan the common IPs first (faster)
            for i in "${common_ips[@]}"; do
                echo -n "."
                ping -c 1 -W 1 "$subnet.$i" &> /dev/null && echo "$subnet.$i" >> "$smb_list_file" &
            done
            wait
            echo " Done!"
            
            # Check for SMB on the known server directly
            echo "Checking if 192.168.0.132 is running SMB..."
            if nc -z -G 1 "192.168.0.132" 445 2>/dev/null || nc -z -G 1 "192.168.0.132" 139 2>/dev/null; then
                echo "✅ SMB service detected on 192.168.0.132"
            else
                echo "⚠️ No SMB service detected on 192.168.0.132"
            fi
            
            # Create a list of SMB hosts
            local smb_hosts=()
            
            # Sort and remove duplicates from the list
            sort -u "$smb_list_file" > "${smb_list_file}.sorted"
            mv "${smb_list_file}.sorted" "$smb_list_file"
            
            # Check all discovered hosts
            echo "Checking discovered hosts..."
            while IFS= read -r ip; do
                # Skip empty lines
                if [ -z "$ip" ]; then
                    continue
                fi
                
                echo -n "Checking $ip... "
                
                # Check if the host responds to SMB port (TCP 445 or 139) with a short timeout
                if nc -z -G 1 "$ip" 445 2>/dev/null || nc -z -G 1 "$ip" 139 2>/dev/null; then
                    echo "SMB service found!"
                    
                    # Try to get hostname (quick lookup)
                    local hostname=$(dscacheutil -q host -a ip_address "$ip" 2>/dev/null | grep "name" | head -1 | awk '{print $2}')
                    
                    if [ -z "$hostname" ] || [ "$hostname" = "$ip" ]; then
                        smb_hosts+=("$ip (SMB)")
                    else
                        smb_hosts+=("$hostname ($ip) (SMB)")
                    fi
                else
                    echo "No SMB service detected."
                fi
            done < "$smb_list_file"
            
            # Check if any SMB hosts were found
            if [ ${#smb_hosts[@]} -eq 0 ]; then
                echo "No SMB servers found on the network."
                echo "Adding 192.168.0.132 as a fallback option."
                smb_hosts+=("192.168.0.132 (Known SMB Server)")
            fi
            
            # Add return option
            smb_hosts+=("Return to connection menu")
            
            # Display the list of hosts
            clear
            echo "===== SMB Servers Found ====="
            echo "Select a host to connect to:"
            echo "-----------------------------------------------------"
            
            menu_select "${smb_hosts[@]}"
            local host_choice=$?
            
            # Check if user selected the return option
            if [ "$host_choice" -eq ${#smb_hosts[@]} ]; then
                # Return to the beginning of the function
                detect_and_connect_smb
                return 0
            fi
            
            # Extract IP from selection (which might include hostname)
            selected_host=$(echo "${smb_hosts[$((host_choice-1))]}" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "${smb_hosts[$((host_choice-1))]}")
            # Keep the OS type from the menu selection
            # os_type is already set above
            ;;
        4) # Manual entry
            read -p "Enter SMB address (e.g., 192.168.1.100 or server.local): " manual_host
            if [ -z "$manual_host" ]; then
                echo "No address entered. Returning to main menu..."
                sleep 2
                return 0
            fi
            selected_host="$manual_host"
            
            # For manual entry, ask for OS type
            clear
            echo "Select the operating system type of the SMB server:"
            local os_options=("MacOS" "Windows" "Linux" "Unknown/Other")
            menu_select "${os_options[@]}"
            local os_choice=$?
            
            case $os_choice in
                1) os_type="MacOS" ;;
                2) os_type="Windows" ;;
                3) os_type="Linux" ;;
                4) os_type="" ;; # Unknown/Other
            esac
            ;;
        5) # Return to main menu
            echo "Returning to main menu..."
            return 0
            ;;
    esac
    

    
    # Now try to list shares on the selected host
    echo "Attempting to list shares on $selected_host..."
    
    # Create temporary file for storing shares
    local shares_list_file=$(mktemp)
    
    # Try to list shares using smbutil with better parsing
    echo "Trying to list shares on $selected_host..."
    
    # First attempt - try with guest access
    smbutil view "//$selected_host" 2>/dev/null > "${shares_list_file}.raw"
    
    # If that fails, try with -g for guest access explicitly
    if [ ! -s "${shares_list_file}.raw" ]; then
        echo "Retrying with explicit guest access..."
        smbutil view -g "//$selected_host" 2>/dev/null > "${shares_list_file}.raw"
    fi
    
    # Process the raw output to extract share names and comments
    if [ -s "${shares_list_file}.raw" ]; then
        # Skip header lines and extract share names and comments
        cat "${shares_list_file}.raw" | grep -v "WORKGROUP\|-----" | tail -n +2 | while read -r line; do
            # Extract share name (first column) and comment (if available)
            share_name=$(echo "$line" | awk '{print $1}')
            share_comment=$(echo "$line" | cut -d' ' -f2- | sed 's/^[[:space:]]*//')
            
            if [ -n "$share_name" ] && [ "$share_name" != "Disk" ]; then
                if [ -n "$share_comment" ] && [ "$share_comment" != "Disk" ]; then
                    echo "$share_name ($share_comment)" >> "$shares_list_file"
                else
                    echo "$share_name" >> "$shares_list_file"
                fi
            fi
        done
    else
        # If we still can't get shares, try a direct approach for common share names
        echo "Unable to list shares. Trying common share names..."
        echo "ROMS" >> "$shares_list_file"
        echo "roms" >> "$shares_list_file"
        echo "games" >> "$shares_list_file"
        echo "games-roms" >> "$shares_list_file"
        echo "share" >> "$shares_list_file"
    fi
    
    # Debug output
    echo "Found shares:"
    cat "$shares_list_file"
    
    # Read the shares into an array
    local smb_shares=()
    while IFS= read -r share; do
        if [ -n "$share" ]; then
            # Skip IPC$ share as it's not useful for file sharing
            if [[ "$share" != "IPC$"* ]]; then
                smb_shares+=("$share")
            fi
        fi
    done < "$shares_list_file"
    
    # Sort the shares alphabetically for better presentation
    IFS=$'\n' sorted_shares=($(sort <<< "${smb_shares[*]}"))
    unset IFS
    smb_shares=("${sorted_shares[@]}")
    
    # Check if any shares were found
    if [ ${#smb_shares[@]} -eq 0 ]; then
        echo "No shares found on $selected_host or unable to access shares."
        
        # Create a menu with options
        local share_options=(
            "Try connecting to 'ROMS' share"
            "Try connecting to 'roms' share"
            "Try connecting to 'games' share"
            "Try connecting to 'games-roms' share"
            "Enter a different share name"
            "Return to main menu"
        )
        
        echo "What would you like to do?"
        menu_select "${share_options[@]}"
        local share_option=$?
        
        case $share_option in
            1) # Try ROMS
                smb_shares=("ROMS")
                ;;
            2) # Try roms
                smb_shares=("roms")
                ;;
            3) # Try games
                smb_shares=("games")
                ;;
            4) # Try games-roms
                smb_shares=("games-roms")
                ;;
            5) # Manual entry
                read -p "Enter share name: " manual_share
                if [ -n "$manual_share" ]; then
                    smb_shares=("$manual_share")
                else
                    echo "No share name entered. Returning to main menu..."
                    sleep 2
                    return 0
                fi
                ;;
            6) # Return to main menu
                echo "Returning to main menu..."
                sleep 2
                return 0
                ;;
        esac
    fi
    
    # Add return option
    smb_shares+=("Return to main menu")
    
    # Display the list of shares
    clear
    echo "===== Available SMB Shares on $selected_host ====="
    echo "Select a share to connect to (use ↑↓ arrows, press Enter to select):"
    echo "-----------------------------------------------------"
    
    # Print a message about what these shares are
    echo "These are the shared folders available on the SMB server."
    echo "Select the one containing your ROM files."
    echo "-----------------------------------------------------"
    
    menu_select "${smb_shares[@]}"
    local share_choice=$?
    
    # Check if user selected the return option
    if [ "$share_choice" -eq ${#smb_shares[@]} ]; then
        echo "Returning to main menu..."
        return 0
    fi
    
    local selected_share="${smb_shares[$((share_choice-1))]}"
    
    # Extract just the share name without any description
    local clean_share=$(echo "$selected_share" | cut -d' ' -f1)
    echo "Selected share: $clean_share"
    
    # Determine the mount point based on the share type
    local mount_point
    local is_rom_share=false
    
    # Check if this is a ROM share
    if [[ "$clean_share" == "games-roms" || "$clean_share" == "games-rom" || "$clean_share" == "roms" || "$clean_share" == "games" ]]; then
        is_rom_share=true
        # For ROM shares, use $HOME/smb-mount/games-roms
        mount_point="$SMB_MOUNT_DIR/games-roms"
    else
        # For non-ROM shares, use $HOME/smb-mount/[share-name]
        mount_point="$SMB_MOUNT_DIR/$clean_share"
    fi
    
    echo "Mount point: $mount_point"
    
    # Unmount if already mounted
    if mount | grep -q "$mount_point"; then
        echo "Unmounting existing mount at $mount_point"
        umount "$mount_point" 2>/dev/null || diskutil unmount "$mount_point" 2>/dev/null
        sleep 1
    fi
    
    # Create mount point if it doesn't exist
    echo "Creating mount point directory..."
    # Create the mount point directory
    mkdir -p "$mount_point" 2>/dev/null
    
    # Verify mount point exists
    if [ ! -d "$mount_point" ]; then
        echo "❌ Failed to create mount point directory at $mount_point"
        echo "Creating a temporary mount point in your home directory instead"
        mount_point="$HOME/Desktop/temp-mount-$clean_share"
        mkdir -p "$mount_point"
        if [ ! -d "$mount_point" ]; then
            echo "❌ Failed to create temporary mount point. Aborting."
            return 1
        fi
        echo "Using temporary mount point: $mount_point"
    fi
    
    # Attempt to mount the share
    echo "\nMounting //$selected_host/$clean_share to $mount_point..."
    
    # Use the appropriate mounting method based on the OS type
    if [ "$os_type" == "MacOS" ] || [ -z "$os_type" ]; then
        # MacOS SMB servers typically work well with standard guest access
        echo "Using MacOS-optimized SMB mounting..."
        mount_smbfs "//guest@$selected_host/$clean_share" "$mount_point" 2>&1
        mount_success=$?
        
        # If that fails, try with the -N flag (common for MacOS servers)
        if [ $mount_success -ne 0 ]; then
            echo "\nRetrying with -N flag (MacOS)..."
            mount_smbfs -N "//guest@$selected_host/$clean_share" "$mount_point" 2>&1
            mount_success=$?
        fi
        
    elif [ "$os_type" == "Windows" ]; then
        # Windows SMB servers often need different authentication options
        echo "Using Windows-optimized SMB mounting..."
        
        # Try Windows-style guest access first
        mount_smbfs -o "nobrowse,noowners,noperm" "//GUEST:@$selected_host/$clean_share" "$mount_point" 2>&1
        mount_success=$?
        
        # If that fails, try with alternative Windows guest syntax
        if [ $mount_success -ne 0 ]; then
            echo "\nRetrying with alternative Windows guest syntax..."
            mount_smbfs -o "nobrowse,noowners,noperm" "//guest:@$selected_host/$clean_share" "$mount_point" 2>&1
            mount_success=$?
        fi
        
        # If still failing, try with SMB version specification (for older Windows servers)
        if [ $mount_success -ne 0 ]; then
            echo "\nRetrying with SMB version specification for Windows..."
            mount_smbfs -o "nobrowse,noowners,noperm,vers=1.0" "//guest@$selected_host/$clean_share" "$mount_point" 2>&1
            mount_success=$?
        fi
        
    elif [ "$os_type" == "Linux" ]; then
        # Linux Samba servers often have different authentication requirements
        echo "Using Linux-optimized SMB mounting..."
        
        # Try standard Linux Samba mounting
        mount_smbfs -o "nobrowse" "//guest@$selected_host/$clean_share" "$mount_point" 2>&1
        mount_success=$?
        
        # If that fails, try with sec=ntlm which is common for Linux Samba
        if [ $mount_success -ne 0 ]; then
            echo "\nRetrying with NTLM security (Linux)..."
            mount_smbfs -o "nobrowse,sec=ntlm" "//guest@$selected_host/$clean_share" "$mount_point" 2>&1
            mount_success=$?
        fi
        
        # Try with null session for Linux
        if [ $mount_success -ne 0 ]; then
            echo "\nRetrying with null session (Linux)..."
            mount_smbfs "//nobody:@$selected_host/$clean_share" "$mount_point" 2>&1
            mount_success=$?
        fi
    fi
    
    # If all OS-specific methods fail, try generic fallback methods
    if [ $mount_success -ne 0 ]; then
        echo "\nTrying generic fallback methods..."
        
        # Try alternative guest syntax as last resort
        mount_smbfs "//GUEST:@$selected_host/$clean_share" "$mount_point" 2>&1
        mount_success=$?
        
        # If that fails, try with no authentication
        if [ $mount_success -ne 0 ]; then
            echo "\nRetrying with no authentication..."
            mount_smbfs "//$selected_host/$clean_share" "$mount_point" 2>&1
            mount_success=$?
        fi
    fi
    
    # Verify the mount was successful
    echo "\nVerifying mount status..."
    
    # Use the mount command's return code as the primary indicator of success
    if [ $mount_success -eq 0 ]; then
        # Try to find the mount in the system mount list for additional verification
        mount_check=$(mount | grep -i "$selected_host/$clean_share")
        point_check=$(mount | grep -i "$mount_point")
        
        # Display mount information if available
        if [ -n "$mount_check" ] || [ -n "$point_check" ]; then
            mount | grep -i "$selected_host/$clean_share" || mount | grep -i "$mount_point"
        else
            echo "Note: Mount command reported success but mount not visible in system mount list."
            echo "This can happen with some SMB configurations but the share should still be accessible."
        fi
        
        echo "\n✅ Mount successful! SMB share mounted at $mount_point"
        
        # Check if we can access the share
        echo "Testing share access..."
        # Try to list the directory and capture any errors
        ls_output=$(ls -la "$mount_point" 2>&1)
        ls_result=$?
        
        if [ $ls_result -eq 0 ] && [ -n "$ls_output" ]; then
            echo "✅ Share contents are accessible"
            
            # List the top-level directories in the share
            echo "\nContents of the SMB share:"
            ls -la "$mount_point" | head -10
            
            # Automatically set this as the ROMs directory
            ROMS_BASE_DIR="$mount_point"
            echo "\nROMs base directory set to: $ROMS_BASE_DIR"
            
            # No symbolic links needed - we're mounting directly like Finder does
            echo "\nShare mounted successfully at: $mount_point"
            
            # Set the ROM base directory based on the share type
            if [ "$is_rom_share" = true ]; then
                # For ROM shares, set the base directory to the mount point
                ROMS_BASE_DIR="$mount_point"
                echo "ROMs base directory set to: $ROMS_BASE_DIR"
            fi

            
            # No symbolic links are used - direct mounting only
            
            # Update all platform directories to use the new base
            NES_DIR="$ROMS_BASE_DIR/nes"
            SNES_DIR="$ROMS_BASE_DIR/snes"
            GENESIS_DIR="$ROMS_BASE_DIR/genesis"
            GB_DIR="$ROMS_BASE_DIR/gb"
            GBA_DIR="$ROMS_BASE_DIR/gba"
            GBC_DIR="$ROMS_BASE_DIR/gbc"
            GAMEGEAR_DIR="$ROMS_BASE_DIR/gamegear"
            NGP_DIR="$ROMS_BASE_DIR/ngp"
            SMS_DIR="$ROMS_BASE_DIR/mastersystem"
            SEGACD_DIR="$ROMS_BASE_DIR/segacd"
            SEGA32X_DIR="$ROMS_BASE_DIR/sega32x"
            SATURN_DIR="$ROMS_BASE_DIR/saturn"
            TG16_DIR="$ROMS_BASE_DIR/tg16"
            TGCD_DIR="$ROMS_BASE_DIR/tgcd"
            PS1_DIR="$ROMS_BASE_DIR/ps1"
            PS2_DIR="$ROMS_BASE_DIR/ps2"
            N64_DIR="$ROMS_BASE_DIR/n64"
            DREAMCAST_DIR="$ROMS_BASE_DIR/dreamcast"
            LYNX_DIR="$ROMS_BASE_DIR/lynx"
            
            # Check if the mounted directory has ROM subdirectories
            echo "\nChecking for existing ROM directories..."
            found_rom_dirs=false
            
            # List of common ROM directory names to check
            common_rom_dirs=("nes" "snes" "genesis" "gb" "gba" "gbc" "n64" "ps1" "dreamcast")
            
            for rom_dir in "${common_rom_dirs[@]}"; do
                if [ -d "$mount_point/$rom_dir" ]; then
                    echo "Found ROM directory: $rom_dir"
                    found_rom_dirs=true
                fi
            done
            
            if [ "$found_rom_dirs" = true ]; then
                echo "\nROM directories found in the mounted share!"
                # Open the file browser to the ROMs directory
                echo "\nOpening $ROMS_BASE_DIR in Finder..."
                open "$ROMS_BASE_DIR"
            else
                echo "\n⚠️ No standard ROM directories found in the mounted share."
                echo "This might not be the correct share for your ROMs."
                echo "You may want to try mounting a different share."
            fi
            
            # Only check for ROM directories without creating them
            echo "\nChecking for ROM directories (not creating any)..."
            for dir in "$NES_DIR" "$SNES_DIR" "$GENESIS_DIR" "$GB_DIR" "$GBA_DIR" "$GBC_DIR" "$GAMEGEAR_DIR" "$NGP_DIR" \
                      "$SMS_DIR" "$SEGACD_DIR" "$SEGA32X_DIR" "$SATURN_DIR" "$TG16_DIR" "$TGCD_DIR" "$PS1_DIR" \
                      "$PS2_DIR" "$N64_DIR" "$DREAMCAST_DIR" "$LYNX_DIR"; do
                if [ -d "$dir" ]; then
                    echo "Found ROM directory: $(basename "$dir")"
                fi
            done
        else
            echo "⚠️ Warning: Share is mounted but contents cannot be accessed."
            
            # Check mount point permissions
            mount_owner=$(ls -ld "$mount_point" | awk '{print $3}')
            current_user=$(whoami)
            
            if [ "$mount_owner" != "$current_user" ]; then
                echo "❌ Permission issue detected: Mount point is owned by $mount_owner, but you are $current_user"
                echo "This is likely a permission issue with the mounted share."
            else
                echo "Mount point ownership looks correct (owned by $current_user)"
            fi
            
            echo "\nPossible solutions:"
            echo "1. Try mounting with credentials (username/password)"
            echo "2. Check the permissions on the SMB server"
            echo "3. Try a different share"
            
            # Try to get more information about the failure
            echo "\nDetailed information about the share:"
            ls -la "$mount_point" 2>&1
            echo "\nPermissions of mount point:"
            ls -ld "$mount_point" 2>&1
        fi
    else
        # If mount_success is 0 but we couldn't access the share, it's a different kind of failure
        if [ $mount_success -eq 0 ]; then
            echo "\n⚠️ Warning: Mount command reported success, but the share contents cannot be accessed."
            echo "This is likely a permission or configuration issue with the share."
            
            # Check mount point permissions
            mount_owner=$(ls -ld "$mount_point" 2>/dev/null | awk '{print $3}')
            current_user=$(whoami)
            
            if [ -n "$mount_owner" ] && [ "$mount_owner" != "$current_user" ]; then
                echo "❌ Permission issue detected: Mount point is owned by $mount_owner, but you are $current_user"
            fi
            
            echo "\nTry the following solutions:"
            echo "1. Mount with credentials (username/password)"
            echo "2. Check permissions on the SMB server"
            echo "3. Try a different share"
        else
            echo "\n❌ Mount failed. The share could not be mounted."
            
            # Check if the server is reachable
            if ping -c 1 -W 1 "$selected_host" &>/dev/null; then
                echo "✅ Server $selected_host is reachable"
                
                # Check if SMB ports are open
                if nc -z -G 1 "$selected_host" 445 &>/dev/null || nc -z -G 1 "$selected_host" 139 &>/dev/null; then
                    echo "✅ SMB service is running on $selected_host"
                    echo "\n⚠️ The server is reachable and SMB service is running, but mount failed."
                    echo "This is likely due to one of the following:"
                    echo "1. The share name '$clean_share' might not exist or is misspelled"
                    echo "2. You need credentials to access this share"
                    echo "3. There might be SMB protocol version incompatibility"
                else
                    echo "❌ No SMB service detected on $selected_host"
                    echo "\nThe server is reachable but SMB ports (445, 139) are not open."
                    echo "Please check if the SMB service is running on the server."
                fi
            else
                echo "❌ Server $selected_host is not reachable"
                echo "\nPlease check your network connection and verify the server address."
            fi
        fi
        
        echo "\n=== Detailed Debugging Information ==="
        echo "1. Mount point: $mount_point"
        ls -ld "$mount_point" 2>&1
        
        echo "\n2. Current SMB mounts:"
        mount | grep -i smbfs || echo "No SMB mounts found"
        
        echo "\n3. Network connectivity:"
        ping -c 1 -W 1 "$selected_host" 2>&1
        
        echo "\n4. SMB ports check:"
        nc -z -v -G 1 "$selected_host" 445 2>&1 || echo "Port 445 not accessible"
        nc -z -v -G 1 "$selected_host" 139 2>&1 || echo "Port 139 not accessible"
        
        echo "\n=== Recommended Actions ==="
        echo "1. Try using Finder to connect to the share (Go > Connect to Server)"
        echo "   Enter: smb://$selected_host/$clean_share"
        echo "2. If Finder asks for credentials, note them for use in this script"
        echo "3. Try selecting a different share name"
        echo "4. Verify the SMB server configuration"
    fi

    # Clean up temporary files
    rm -f "$smb_list_file" "$shares_list_file"
    
    read -p "Press Enter to continue..."
    return 0
}

# Function to show menu
show_menu() {
    clear
    echo "===== ROM Downloader ====="
    echo "Current Platform: $(to_uppercase $CURRENT_PLATFORM)"
    echo "============================="
    echo "Select an option (use ↑↓ arrows, press Enter to select):"
    echo "-----------------------------------------------------"
    
    local menu_options=(
        "Connect to SMB"
        "Search ROMs"
        "List All ROMs"
        "Download All ROMs"
        "Open ROMs Folder"
        "Verify ROM Directories"
        "Copy ROMs to External Drive"
        "Exit"
    )
    
    menu_select "${menu_options[@]}"
    choice=$?
    
    # Convert choice 8 (Exit) to 0 for compatibility
    if [ "$choice" -eq 8 ]; then
        choice=0
    fi
}

# Function to list available platforms
list_platforms() {
    clear
    echo "===== Available Platforms ====="
    
    # Explicitly list all platforms with their URLs
    local i=1
    local platforms_array=("nes" "snes" "gb" "gba" "gbc" "sms" "genesis" "segacd" "sega32x" "saturn" "gg" "ngp" "tg16" "tgcd" "ps1" "ps2" "n64" "dreamcast" "lynx")
    local descriptions=(
        "Nintendo Entertainment System"
        "Super Nintendo Entertainment System"
        "Game Boy"
        "Game Boy Advance"
        "Game Boy Color"
        "Sega Master System"
        "Sega Genesis"
        "Sega CD"
        "Sega 32X"
        "Sega Saturn"
        "Sega Game Gear"
        "Neo Geo Pocket"
        "TurboGrafx-16"
        "TurboGrafx-CD"
        "PlayStation"
        "PlayStation 2"
        "Nintendo 64"
        "Sega Dreamcast"
        "Atari Lynx"
    )
    
    # Display platforms
    for ((i=0; i<${#platforms_array[@]}; i++)); do
        platform="${platforms_array[$i]}"
        description="${descriptions[$i]}"
        echo "$((i+1)). $(to_uppercase $platform) - $description"
        echo "   URL: $(get_archive_url $platform)"
    done
    
    echo "============================="
    read -p "Press Enter to continue..."
}

# Function to search and list ROMs
search_roms() {
    local search_term="$1"
    local platform="$2"
    
    # If platform is not provided, use the current platform
    if [ -z "$platform" ]; then
        platform="$CURRENT_PLATFORM"
    fi
    
    # Get the archive URL from the function
    local archive_url=$(get_archive_url "$platform")
    
    if [ -z "$archive_url" ]; then
        echo "Error: No archive URL found for platform $(to_uppercase $platform)"
        read -p "Press Enter to continue..."
        return 1
    fi
    
    echo "Searching for ROMs in $(to_uppercase $platform) platform..."
    echo "Archive URL: $archive_url"
    
    # Get the list of ROMs from the archive
    echo "Fetching ROM list..."
    
    # Create a temporary file for storing ROM names
    local rom_list_file=$(mktemp)
    
    # Check if we're dealing with GBC platform which has .gbc files instead of .zip files
    if [ "$platform" = "gbc" ]; then
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.gbc">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$rom_list_file"
    elif [ "$platform" = "ps1" ]; then
        # PS1 platform uses .bin and .cue files
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.cue">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$rom_list_file"
    else
        # Get all zip files from the archive
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.zip">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$rom_list_file"
    fi
    
    # Filter ROMs based on search term if provided
    local filtered_roms=()
    local rom_name
    
    while IFS= read -r rom_name; do
        # Decode URL-encoded names
        rom_name=$(urldecode "$rom_name")
        
        # If search term is provided, filter the results
        if [ -n "$search_term" ]; then
            if echo "$rom_name" | grep -qi "$search_term"; then
                filtered_roms+=("$rom_name")
            fi
        else
            filtered_roms+=("$rom_name")
        fi
    done < "$rom_list_file"
    
    # Remove temporary file
    rm -f "$rom_list_file"
    
    # Display results with arrow key selection
    if [ ${#filtered_roms[@]} -eq 0 ]; then
        echo "No ROMs found matching your search."
        read -p "Press Enter to continue..."
        return 0
    fi
    
    # Continue showing ROM selection until user chooses to exit
    local continue_selection=1
    while [ $continue_selection -eq 1 ]; do
        clear
        echo "Found ${#filtered_roms[@]} ROMs matching your search"
        echo "Use arrow keys or enter number to select a ROM to download or return to main menu"
        echo "-----------------------------------------------------"
        
        # Add "Return to Main Menu" as the last option
        local display_options=("${filtered_roms[@]}" "Return to Main Menu")
        
        # Display ROMs with arrow key selection and numbers
        menu_select "${display_options[@]}"
        local selected=$?
        
        # Check if user selected the last option (Return to Main Menu)
        if [ $selected -eq ${#display_options[@]} ]; then
            echo "Returning to main menu..."
            break
        # Check if user pressed ESC (selected will be 0)
        elif [ $selected -eq 0 ]; then
            echo "Returning to main menu..."
            break
        fi
        
        # Download the selected ROM without asking for confirmation
        local selected_rom="${display_options[$((selected-1))]}"
        
        # Download the ROM immediately
        download_rom "$selected_rom" "$platform"
        
        # Automatically open the ROMs folder
        echo "\nOpening ROMs folder..."
        open_roms_folder
        
        # Brief pause to let user see the download completed
        sleep 1
        
        # Continue the loop to allow selecting another ROM
        # No additional prompts - just go back to the ROM selection list
    done
    
    echo "Returning to main menu..."
}

# Function to download a ROM
download_rom() {
    local rom_file="$1"
    local platform="$2"
    
    # If platform is not provided, use the current platform
    if [ -z "$platform" ]; then
        platform="$CURRENT_PLATFORM"
    fi
    
    # Get the archive URL from the function
    local archive_url=$(get_archive_url "$platform")
    
    if [ -z "$archive_url" ]; then
        echo "Error: No archive URL found for platform $(to_uppercase $platform)"
        return 1
    fi
    
    # Extract just the filename without extension for display
    local rom_name=$(basename "$rom_file")
    local decoded_rom_name=$(urldecode "$rom_name")
    
    echo "Downloading ROM: $decoded_rom_name"
    echo "Platform: $(to_uppercase $platform)"
    
    # Get the correct platform directory
    local platform_dir=$(get_platform_dir "$platform")
    
    echo "ROM will be saved to: $platform_dir"
    
    # URL encode the ROM file for downloading
    local encoded_rom_file=$(echo "$rom_file" | sed 's/ /%20/g')
    
    # Construct the full download URL
    local download_url="${archive_url}/${encoded_rom_file}"
    echo "Download URL: $download_url"
    
    # Create platform directory if it doesn't exist
    mkdir -p "$platform_dir"
    
    # Download the ROM file
    curl -s -L -o "$platform_dir/$decoded_rom_name" "$download_url"
    local download_status=$?
    
    # For PS1 platform, also download the corresponding .bin file if we're downloading a .cue file
    if [ "$platform" = "ps1" ] && [[ "$rom_file" == *".cue" ]]; then
        local bin_file="${rom_file%.cue}.bin"
        local encoded_bin_file=$(echo "$bin_file" | sed 's/ /%20/g')
        local bin_download_url="${archive_url}/${encoded_bin_file}"
        local decoded_bin_name=$(urldecode "$(basename "$bin_file")")
        
        echo "Also downloading corresponding .bin file: $decoded_bin_name"
        curl -s -L -o "$platform_dir/$decoded_bin_name" "$bin_download_url"
        
        if [ $? -eq 0 ]; then
            echo ".bin file download successful!"
        else
            echo "Error downloading .bin file. You may need to download it manually."
        fi
    fi
    
    if [ $download_status -eq 0 ]; then
        echo "Download successful!"
        echo "ROM saved to: $platform_dir/$decoded_rom_name"
    else
        echo "Error downloading ROM. Please try again."
    fi
    
    # No 'Press Enter to continue' here - let the calling function handle the flow
}

# Function to download all ROMs for a platform
download_all_roms() {
    local platform="$CURRENT_PLATFORM"
    
    # Get the archive URL from the function
    local archive_url=$(get_archive_url "$platform")
    
    if [ -z "$archive_url" ]; then
        echo "Error: No archive URL found for platform $(to_uppercase $platform)"
        read -p "Press Enter to continue..."
        return 1
    fi
    
    echo "Downloading all ROMs for $(to_uppercase $platform) platform..."
    echo "Archive URL: $archive_url"
    
    # Get the list of ROMs from the archive
    echo "Fetching ROM list..."
    
    # Create a temporary file for storing ROM names
    local rom_list_file=$(mktemp)
    
    # Check if we're dealing with GBC platform which has .gbc files instead of .zip files
    if [ "$platform" = "gbc" ]; then
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.gbc">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$rom_list_file"
    elif [ "$platform" = "ps1" ]; then
        # PS1 platform uses .bin and .cue files
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.cue">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$rom_list_file"
    else
        # Get all zip files from the archive
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.zip">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$rom_list_file"
    fi
    
    # Filter ROMs based on platform
    local filtered_roms=()
    local rom_name
    
    while IFS= read -r rom_name; do
        # Decode URL-encoded names
        rom_name=$(urldecode "$rom_name")
        
        # If we're dealing with a specific platform, filter the results
        case "$platform" in
            "nes")
                if echo "$rom_name" | grep -qi "nes\|nintendo\|famicom"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "snes")
                if echo "$rom_name" | grep -qi "snes\|super\|sfc"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "genesis")
                if echo "$rom_name" | grep -qi "genesis\|mega\|sega\|32x\|md\|gen"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "gb")
                if echo "$rom_name" | grep -qi "gameboy\|game boy\|gb\|gbc"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "gba")
                if echo "$rom_name" | grep -qi "advance\|gba"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "gg")
                if echo "$rom_name" | grep -qi "gamegear\|gg"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "ngp")
                if echo "$rom_name" | grep -qi "neogeo\|ngp"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "sms")
                if echo "$rom_name" | grep -qi "master system\|mastersystem\|sms"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "gbc")
                if echo "$rom_name" | grep -qi "gameboy\|color\|gbc"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
            "ps1")
                if echo "$rom_name" | grep -qi "playstation\|ps1\|psx"; then
                    filtered_roms+=("$rom_name")
                fi
                ;;
        esac
    done < "$rom_list_file"
    
    # Remove temporary file
    rm -f "$rom_list_file"
    
    # Ask for confirmation before downloading all ROMs
    read -p "Do you want to download all ${#filtered_roms[@]} ROMs? (y/n): " confirm
    
    if [ "$confirm" != "y" ]; then
        echo "Download canceled."
        read -p "Press Enter to continue..."
        return 0
    fi
    
    # Get the correct platform directory
    local platform_dir=$(get_platform_dir "$platform")
    
    echo "Downloading ROMs to $platform_dir..."
    
    # Download each ROM
    local i=1
    for rom_file in "${filtered_roms[@]}"; do
        echo "Downloading ROM $i/${#filtered_roms[@]}: $rom_file"
        
        # Extract just the filename without path
        local filename=$(basename "$rom_file")
        
        # Download the ROM
        curl -s -L "$archive_url/$rom_file" -o "$platform_dir/$filename"
        
        # Check if download was successful
        if [ $? -eq 0 ]; then
            echo "✓ Downloaded: $filename"
        else
            echo "✗ Failed to download: $filename"
        fi
        
        ((i++))
        
        # Add a small delay between downloads to avoid overwhelming the server
        sleep 1
    done
    
    echo "Download complete. ${#filtered_roms[@]} ROMs downloaded to $platform_dir"
    
    read -p "Press Enter to continue..."
    return 0
}

# Function to verify ROM directories
verify_rom_directories() {
    local all_ok=true
    
    # Check if base directory exists
    if [ ! -d "$ROMS_BASE_DIR" ]; then
        echo "The ROM directory $ROMS_BASE_DIR does not exist."
        all_ok=false
    fi
    
    # Check platform directories
    for platform in nes snes genesis gb gba gbc gamegear ngp mastersystem segacd sega32x saturn tg16 tgcd ps1 ps2 n64 dreamcast lynx; do
        local dir=$(get_platform_dir "$platform")
        if [ ! -d "$dir" ]; then
            echo "Platform directory $dir does not exist."
            all_ok=false
        fi
    done
    
    if $all_ok; then
        echo "All ROM directories exist."
    fi
}

# Function to test archive URLs
test_archive_urls() {
    clear
    echo "===== Testing Archive URLs ====="
    
    for platform in "nes" "snes" "gb" "gba" "gbc" "sms" "genesis" "segacd" "sega32x" "saturn" "gg" "ngp" "tg16" "tgcd" "ps1" "ps2" "n64" "dreamcast" "lynx"; do
        local archive_url=$(get_archive_url "$platform")
        
        echo "Testing $(to_uppercase $platform) URL: $archive_url"
        local http_code=$(curl -s -o /dev/null -w "%{http_code}" "$archive_url")
        
        if [ "$http_code" -eq 200 ]; then
            echo "✅ $(to_uppercase $platform) archive is accessible (HTTP $http_code)"
        else
            echo "❌ $(to_uppercase $platform) archive is NOT accessible (HTTP $http_code)"
            
            # Since we're now using the associative array consistently,
            # there are no alternative URLs to try
            echo "   No alternative URL available."
        fi
        echo ""
    done
    
    echo "URL testing complete."
    read -p "Press Enter to continue..."
}

# Function to copy ROMs to external drive
copy_roms_to_external() {
    echo "Enter the path to the external drive:"
    read -r external_path
    
    if [ ! -d "$external_path" ]; then
        echo "Directory $external_path does not exist."
        return 1
    fi
    
    if [ ! -w "$external_path" ]; then
        echo "No write permission for $external_path"
        return 1
    fi
    
    # Copy each platform's ROMs
    for platform in "nes" "snes" "genesis" "gb" "gba" "gg" "ngp" "sms"; do
        local src_dir="$ROMS_BASE_DIR/$platform"
        local dst_dir="$external_path/$platform"
        
        if [ -d "$src_dir" ]; then
            echo "Copying $platform ROMs..."
            mkdir -p "$dst_dir"
            
            # Use rsync if available for better performance and resume capability
            if command -v rsync >/dev/null 2>&1; then
                rsync -av "$src_dir/" "$dst_dir/"
            else
                # Fallback to cp if rsync is not available
                cp -R "$src_dir/"* "$dst_dir/" 2>/dev/null || true
            fi
            
            if [ $? -eq 0 ]; then
                echo "Successfully copied $platform ROMs to $dst_dir"
            else
                echo "Failed to copy some or all $platform ROMs"
            fi
        else
            echo "No $platform ROMs found in $src_dir"
        fi
    done
    
    echo "ROM copying process completed."
    read -p "Press Enter to continue..."
}

# Main function
main_menu() {
    # Set default platform if not already set
    if [ -z "$CURRENT_PLATFORM" ]; then
        CURRENT_PLATFORM="genesis"
        echo "Default platform set to Genesis"
    fi
    
    while true; do
        show_menu
        
        case $choice in
            1)
                clear
                echo "===== Connect to SMB ====="
                detect_and_connect_smb
                ;;
            2)
                clear
                echo "===== Search ROMs ====="
                select_platform
                read -p "Enter search term: " search_term
                if [ -n "$search_term" ]; then
                    clear
                    search_roms "$search_term" "$CURRENT_PLATFORM"
                fi
                ;;
            3)
                clear
                echo "===== List All ROMs ====="
                select_platform
                search_roms "" "$CURRENT_PLATFORM"
                ;;
            4)
                clear
                echo "===== Download All ROMs ====="
                select_platform
                
                echo "Continue? (use ↑↓ arrows, press Enter to select)"
                echo "-----------------------------------------------------"
                local confirm_options=("Yes" "No")
                menu_select "${confirm_options[@]}"
                local confirm_choice=$?
                
                if [ "$confirm_choice" -eq 1 ]; then
                    download_all_roms "$CURRENT_PLATFORM"
                    read -p "Press Enter to continue..."
                fi
                ;;
            5)
                clear
                echo "===== Open ROMs Folder ====="
                select_platform
                open_roms_folder
                read -p "Press Enter to continue..."
                ;;
            6)
                clear
                echo "===== Verify ROM Directories ====="
                verify_rom_directories
                ;;
            7)
                clear
                echo "===== Copy ROMs to External Drive ====="
                copy_roms_to_external
                ;;
            0)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice. Please try again."
                sleep 1
                ;;
        esac
    done
}

# Clean up on exit
trap "rm -f $TEMP_FILE; tput cnorm" EXIT INT TERM

# Start the main menu
main_menu
