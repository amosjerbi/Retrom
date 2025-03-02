#!/bin/bash

# Set variables
CURRENT_PLATFORM=""
DEFAULT_ROMS_BASE_DIR="$HOME/Desktop/$(whoami)/games-roms"
ROMS_BASE_DIR="$DEFAULT_ROMS_BASE_DIR"

# Check if DEFAULT_ROMS_BASE_DIR exists
if [ -d "$DEFAULT_ROMS_BASE_DIR" ]; then
    echo "Default ROMs directory exists at: $DEFAULT_ROMS_BASE_DIR"
else
    echo "Default ROMs directory does not exist at: $DEFAULT_ROMS_BASE_DIR"
    echo "Do you want to create it? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        if ! mkdir -p "$DEFAULT_ROMS_BASE_DIR"; then
            echo "Cannot create default directory $DEFAULT_ROMS_BASE_DIR. Please check permissions."
            exit 1
        else
            echo "Default ROMs directory created at: $DEFAULT_ROMS_BASE_DIR"
        fi
    else
        echo "Default ROMs directory not created. Using current directory instead."
        ROMS_BASE_DIR="$(pwd)"
    fi
fi

# Function to set ROM base directory
set_roms_base_dir() {
    echo "Current ROMs directory: $ROMS_BASE_DIR"
    echo "Do you want to change the ROMs directory? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "Enter new ROMs directory path:"
        read -r new_dir
        if [ -n "$new_dir" ]; then
            ROMS_BASE_DIR="$new_dir"
            echo "ROMs directory changed to: $ROMS_BASE_DIR"
            # Update all platform directories
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
        fi
    fi
}

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

# Define function to get archive URL for a platform
get_archive_url() {
    local platform="$1"
    
    case "$platform" in
        "nes")
            echo "https://archive.org/download/"
            ;;
        "snes")
            echo "https://archive.org/download/"
            ;;
        "genesis")
            echo "https://archive.org/download/"
            ;;
        "gb")
            echo "https://archive.org/download/"
            ;;
        "gba")
            echo "https://archive.org/download/"
            ;;
        "gbc")
            echo "https://archive.org/download/"
            ;;
        "gg")
            echo "https://archive.org/download/"
            ;;
        "ngp")
            echo "https://archive.org/download/"
            ;;
        "sms")
            echo "https://archive.org/download/"
            ;;
        "segacd")
            echo "https://archive.org/download/"
            ;;
        "sega32x")
            echo "https://archive.org/download/"
            ;;
        "saturn")
            echo "https://archive.org/download/"
            ;;
        "tg16")
            echo "https://archive.org/download/"
            ;;
        "tgcd")
            echo "https://archive.org/download/"
            ;;
        "ps1")
            echo "https://archive.org/download/"
            ;;
        "ps2")
            echo "https://archive.org/download/"
            ;;
        "n64")
            echo "https://archive.org/download/"
            ;;
        "dreamcast")
            echo "https://archive.org/download/"
            ;;
        "lynx")
            echo "https://archive.org/download/"
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

# Create ROM directory if it doesn't exist
if [ ! -d "$ROMS_BASE_DIR" ]; then
    if ! mkdir -p "$ROMS_BASE_DIR"; then
        echo "Cannot create directory $ROMS_BASE_DIR. Please check permissions."
        exit 1
    fi
fi

# Create NES directory if it doesn't exist
if [ ! -d "$NES_DIR" ]; then
    if ! mkdir -p "$NES_DIR"; then
        echo "Cannot create NES directory $NES_DIR. Please check permissions."
        exit 1
    fi
fi

# Create SNES directory if it doesn't exist
if [ ! -d "$SNES_DIR" ]; then
    if ! mkdir -p "$SNES_DIR"; then
        echo "Cannot create SNES directory $SNES_DIR. Please check permissions."
        exit 1
    fi
fi

# Create Genesis directory if it doesn't exist
if [ ! -d "$GENESIS_DIR" ]; then
    if ! mkdir -p "$GENESIS_DIR"; then
        echo "Cannot create Genesis directory $GENESIS_DIR. Please check permissions."
        exit 1
    fi
fi

# Create GB directory if it doesn't exist
if [ ! -d "$GB_DIR" ]; then
    if ! mkdir -p "$GB_DIR"; then
        echo "Cannot create GB directory $GB_DIR. Please check permissions."
        exit 1
    fi
fi

# Create GBA directory if it doesn't exist
if [ ! -d "$GBA_DIR" ]; then
    if ! mkdir -p "$GBA_DIR"; then
        echo "Cannot create GBA directory $GBA_DIR. Please check permissions."
        exit 1
    fi
fi

# Create GG directory if it doesn't exist
if [ ! -d "$GAMEGEAR_DIR" ]; then
    if ! mkdir -p "$GAMEGEAR_DIR"; then
        echo "Cannot create GG directory $GAMEGEAR_DIR. Please check permissions."
        exit 1
    fi
fi

# Create NGP directory if it doesn't exist
if [ ! -d "$NGP_DIR" ]; then
    if ! mkdir -p "$NGP_DIR"; then
        echo "Cannot create NGP directory $NGP_DIR. Please check permissions."
        exit 1
    fi
fi

# Create SMS directory if it doesn't exist
if [ ! -d "$SMS_DIR" ]; then
    if ! mkdir -p "$SMS_DIR"; then
        echo "Cannot create Master System directory $SMS_DIR. Please check permissions."
        exit 1
    fi
fi

# Create GBC directory if it doesn't exist
if [ ! -d "$GBC_DIR" ]; then
    if ! mkdir -p "$GBC_DIR"; then
        echo "Cannot create Game Boy Color directory $GBC_DIR. Please check permissions."
        exit 1
    fi
fi

# Create Sega CD directory if it doesn't exist
if [ ! -d "$SEGACD_DIR" ]; then
    if ! mkdir -p "$SEGACD_DIR"; then
        echo "Cannot create Sega CD directory $SEGACD_DIR. Please check permissions."
        exit 1
    fi
fi

# Create Sega 32X directory if it doesn't exist
if [ ! -d "$SEGA32X_DIR" ]; then
    if ! mkdir -p "$SEGA32X_DIR"; then
        echo "Cannot create Sega 32X directory $SEGA32X_DIR. Please check permissions."
        exit 1
    fi
fi

# Create Saturn directory if it doesn't exist
if [ ! -d "$SATURN_DIR" ]; then
    if ! mkdir -p "$SATURN_DIR"; then
        echo "Cannot create Saturn directory $SATURN_DIR. Please check permissions."
        exit 1
    fi
fi

# Create TurboGrafx-16 directory if it doesn't exist
if [ ! -d "$TG16_DIR" ]; then
    if ! mkdir -p "$TG16_DIR"; then
        echo "Cannot create TurboGrafx-16 directory $TG16_DIR. Please check permissions."
        exit 1
    fi
fi

# Create TurboGrafx-CD directory if it doesn't exist
if [ ! -d "$TGCD_DIR" ]; then
    if ! mkdir -p "$TGCD_DIR"; then
        echo "Cannot create TurboGrafx-CD directory $TGCD_DIR. Please check permissions."
        exit 1
    fi
fi

# Create PlayStation directory if it doesn't exist
if [ ! -d "$PS1_DIR" ]; then
    if ! mkdir -p "$PS1_DIR"; then
        echo "Cannot create PlayStation directory $PS1_DIR. Please check permissions."
        exit 1
    fi
fi

# Create PlayStation 2 directory if it doesn't exist
if [ ! -d "$PS2_DIR" ]; then
    if ! mkdir -p "$PS2_DIR"; then
        echo "Cannot create PlayStation 2 directory $PS2_DIR. Please check permissions."
        exit 1
    fi
fi

# Create Nintendo 64 directory if it doesn't exist
if [ ! -d "$N64_DIR" ]; then
    if ! mkdir -p "$N64_DIR"; then
        echo "Cannot create Nintendo 64 directory $N64_DIR. Please check permissions."
        exit 1
    fi
fi

# Create Dreamcast directory if it doesn't exist
if [ ! -d "$DREAMCAST_DIR" ]; then
    if ! mkdir -p "$DREAMCAST_DIR"; then
        echo "Cannot create Dreamcast directory $DREAMCAST_DIR. Please check permissions."
        exit 1
    fi
fi

# Create Lynx directory if it doesn't exist
if [ ! -d "$LYNX_DIR" ]; then
    if ! mkdir -p "$LYNX_DIR"; then
        echo "Cannot create Lynx directory $LYNX_DIR. Please check permissions."
        exit 1
    fi
fi

# Check if directories are writable
if [ ! -w "$ROMS_BASE_DIR" ]; then
    echo "$ROMS_BASE_DIR is not writable"
    exit 1
fi

if [ ! -w "$NES_DIR" ]; then
    echo "$NES_DIR is not writable"
    exit 1
fi

if [ ! -w "$SNES_DIR" ]; then
    echo "$SNES_DIR is not writable"
    exit 1
fi

if [ ! -w "$GENESIS_DIR" ]; then
    echo "$GENESIS_DIR is not writable"
    exit 1
fi

if [ ! -w "$GB_DIR" ]; then
    echo "$GB_DIR is not writable"
    exit 1
fi

if [ ! -w "$GBA_DIR" ]; then
    echo "$GBA_DIR is not writable"
    exit 1
fi

if [ ! -w "$GAMEGEAR_DIR" ]; then
    echo "$GAMEGEAR_DIR is not writable"
    exit 1
fi

if [ ! -w "$NGP_DIR" ]; then
    echo "$NGP_DIR is not writable"
    exit 1
fi

if [ ! -w "$SMS_DIR" ]; then
    echo "$SMS_DIR is not writable"
    exit 1
fi

# Function to decode URL-encoded strings
urldecode() {
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

# Function to convert to uppercase
to_uppercase() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

# Create the destination directory if it doesn't exist
mkdir -p "$ROMS_BASE_DIR"

# Function to open the ROMs folder
open_roms_folder() {
    local platform_dir=$(get_platform_dir "$CURRENT_PLATFORM")
    
    # Create directory if it doesn't exist
    mkdir -p "$platform_dir"
    
    # Open the directory
    if [ "$(uname)" == "Darwin" ]; then
        # macOS
        open "$platform_dir"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Linux
        if command -v xdg-open > /dev/null; then
            xdg-open "$platform_dir"
        else
            echo "Cannot open folder: xdg-open not available"
        fi
    else
        echo "Cannot open folder: Unsupported operating system"
    fi
}

# Function to select a platform
select_platform() {
    echo "Select a platform:"
    echo "1. NES (Nintendo Entertainment System)"
    echo "2. SNES (Super Nintendo)"
    echo "3. GB (Game Boy)"
    echo "4. GBA (Game Boy Advance)"
    echo "5. GBC (Game Boy Color)"
    echo "6. SMS (Sega Master System)"
    echo "7. Genesis (Sega Genesis)"
    echo "8. SEGACD (Sega CD)"
    echo "9. SEGA32X (Sega 32X)"
    echo "10. SATURN (Sega Saturn)"
    echo "11. GG (Sega Game Gear)"
    echo "12. NGP (Neo Geo Pocket)"
    echo "13. TG16 (TurboGrafx-16)"
    echo "14. TGCD (TurboGrafx-CD)"
    echo "15. PS1 (PlayStation)"
    echo "16. PS2 (PlayStation 2)"
    echo "17. N64 (Nintendo 64)"
    echo "18. DREAMCAST (Sega Dreamcast)"
    echo "19. LYNX (Atari Lynx)"
    
    read -p "Enter your choice (1-19): " platform_choice
    
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

# Function to display a menu
show_menu() {
    clear
    echo "===== ROM Downloader ====="
    echo "Current Platform: $(to_uppercase $CURRENT_PLATFORM)"
    echo "============================="
    echo "1. Search ROMs"
    echo "2. List All ROMs"
    echo "3. Download All ROMs"
    echo "4. Open ROMs Folder"
    echo "5. Verify ROM Directories"
    echo "6. Copy ROMs to External Drive"
    echo "0. Exit"
    echo "============================="
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
    echo "Fetching initial ROM list..."
    
    # Check if we're dealing with GBC platform which has .gbc files instead of .zip files
    if [ "$platform" = "gbc" ]; then
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.gbc">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
    elif [ "$platform" = "ps1" ]; then
        # PS1 platform uses .bin and .cue files
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.cue">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
    else
        # Get all zip files from the archive
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.zip">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
    fi
    
    local initial_count=$(wc -l < "$TEMP_FILE")
    echo "Initial ROM count: $initial_count"
    
    # Save all ROMs before filtering
    cp "$TEMP_FILE" "${TEMP_FILE}.all"
    
    # If we're searching for a specific game, do minimal filtering
    if [ -n "$search_term" ]; then
        echo "Searching for ROMs containing '$search_term' in $(to_uppercase $platform) platform..."
        grep -i "$search_term" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
        
        # If we found results, use them
        local search_count=$(wc -l < "${TEMP_FILE}.filtered")
        if [ "$search_count" -gt 0 ]; then
            mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
        else
            # If no results with direct search, try a more lenient approach
            # For example, "sonic" might be in "Sonic the Hedgehog" or "Sonic & Knuckles"
            echo "No direct matches found, trying more lenient search..."
            
            # Make sure we have a backup of all ROMs
            if [ ! -f "${TEMP_FILE}.all" ]; then
                # If the .all file doesn't exist, recreate it
                if [ "$platform" = "gbc" ]; then
                    curl -s "$archive_url/" | grep -o '<a href="[^"]*\.gbc">' | 
                    sed 's/<a href="\([^"]*\)">/\1/' > "${TEMP_FILE}.all"
                elif [ "$platform" = "ps1" ]; then
                    curl -s "$archive_url/" | grep -o '<a href="[^"]*\.cue">' | 
                    sed 's/<a href="\([^"]*\)">/\1/' > "${TEMP_FILE}.all"
                else
                    curl -s "$archive_url/" | grep -o '<a href="[^"]*\.zip">' | 
                    sed 's/<a href="\([^"]*\)">/\1/' > "${TEMP_FILE}.all"
                fi
            fi
            
            # Use the original list of all ROMs
            cp "${TEMP_FILE}.all" "$TEMP_FILE"
            
            # Try different variations of the search term
            grep -i "$search_term" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If still no results, try to be even more lenient
            search_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$search_count" -eq 0 ]; then
                echo "Still no matches, showing all ROMs for manual selection..."
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
            else
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
        fi
    else
        # Less restrictive platform-specific filtering when not searching for a specific game
        case "$platform" in
            "nes")
                # Try to find NES-specific ROMs
                grep -i "nes\|nintendo\|famicom" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of NES ROMs, use those
                local nes_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$nes_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-NES ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "snes")
                # Try to find SNES-specific ROMs
                grep -i "snes\|super\|sfc" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of SNES ROMs, use those
                local snes_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$snes_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                    # Remove obvious non-SNES games
                    grep -v -i "genesis\|megadrive\|32x\|sega\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-SNES ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "genesis")
                # Try to find Genesis-specific ROMs
                grep -i "genesis\|mega\|sega\|32x\|md\|gen" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of Genesis ROMs, use those
                local genesis_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$genesis_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                    # Remove obvious non-Genesis games
                    grep -v -i "nintendo\|nes\|snes\|famicom\|mario\|zelda\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-Genesis ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "nintendo\|nes\|snes\|famicom\|mario\|zelda\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "gb")
                # Try to find GB-specific ROMs
                grep -i "gameboy\|game boy\|gb\|gbc" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of GB ROMs, use those
                local gb_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$gb_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                    # Remove GBA games
                    grep -v -i "advance\|gba" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-GB ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|advance\|gba\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "gba")
                # Try to find GBA-specific ROMs
                grep -i "advance\|gba" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of GBA ROMs, use those
                local gba_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$gba_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-GBA ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "gg")
                # Try to find GG-specific ROMs
                grep -i "gamegear\|gg" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of GG ROMs, use those
                local gg_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$gg_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-GG ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "ngp")
                # Try to find NGP-specific ROMs
                grep -i "neogeo\|ngp" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of NGP ROMs, use those
                local ngp_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$ngp_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-NGP ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "sms")
                # Try to find SMS-specific ROMs
                grep -i "master system\|mastersystem\|sms" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of SMS ROMs, use those
                local sms_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$sms_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-SMS ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox\|gameboy\|gba\|advance" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "gbc")
                # Try to find GBC-specific ROMs
                grep -i "gameboy\|color\|gbc" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of GBC ROMs, use those
                local gbc_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$gbc_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-GBC ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox\|advance\|gba" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
            "ps1")
                # Try to find PS1-specific ROMs
                grep -i "playstation\|ps1\|psx" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                
                # If we found a good number of PS1 ROMs, use those
                local ps1_count=$(wc -l < "${TEMP_FILE}.filtered")
                if [ "$ps1_count" -gt 50 ]; then
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                else
                    # Otherwise, use all ROMs and just exclude obvious non-PS1 ones
                    cp "${TEMP_FILE}.all" "$TEMP_FILE"
                    grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|gameboy\|gba\|advance\|xbox\|ps2" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                    mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                fi
                ;;
        esac
    fi
    
    # Decode URL-encoded filenames
    echo "Decoding URL-encoded filenames..."
    > "${TEMP_FILE}.decoded"
    while IFS= read -r line; do
        decoded=$(urldecode "$line")
        echo "$decoded" >> "${TEMP_FILE}.decoded"
    done < "$TEMP_FILE"
    mv "${TEMP_FILE}.decoded" "$TEMP_FILE"
    
    # Count the number of results before filtering by search term
    local total=$(wc -l < "$TEMP_FILE")
    echo "Found $total total ROMs in the archive for $(to_uppercase $platform) after filtering"
    
    if [ "$total" -eq 0 ]; then
        echo "No ROMs found for platform $(to_uppercase $platform)"
        echo "Trying alternative approach..."
        
        # Alternative approach: get all zip files and rely on user to select the right ones
        if [ "$platform" = "gbc" ]; then
            curl -s "$archive_url/" | grep -o '<a href="[^"]*\.gbc">' | 
            sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
        elif [ "$platform" = "ps1" ]; then
            curl -s "$archive_url/" | grep -o '<a href="[^"]*\.cue">' | 
            sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
        else
            curl -s "$archive_url/" | grep -o '<a href="[^"]*\.zip">' | 
            sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
        fi
        
        # Decode URL-encoded filenames
        > "${TEMP_FILE}.decoded"
        while IFS= read -r line; do
            decoded=$(urldecode "$line")
            echo "$decoded" >> "${TEMP_FILE}.decoded"
        done < "$TEMP_FILE"
        mv "${TEMP_FILE}.decoded" "$TEMP_FILE"
        
        total=$(wc -l < "$TEMP_FILE")
        echo "Found $total total zip files in the archive"
    fi
    
    # Count the number of results after filtering
    local count=$(wc -l < "$TEMP_FILE")
    
    if [ "$count" -eq 0 ]; then
        echo "No ROMs found matching '$search_term'"
        read -p "Press Enter to continue..."
        return 1
    else
        if [ -n "$search_term" ]; then
            echo "Found $count ROMs matching '$search_term'"
        else
            echo "Displaying all $count ROMs"
        fi
    fi
    
    echo ""
    
    # ROM selection loop - continue until user chooses to exit
    while true; do
        # Display results with numbers
        local i=1
        while read -r line; do
            # Extract just the filename without extension for display
            local display_name=$(basename "$line")
            echo "$i. $display_name"
            ((i++))
            
            # Add pagination for large lists
            if [ $((i % 20)) -eq 0 ]; then
                echo ""
                read -p "Press Enter to see more ROMs (or type 'q' to stop listing): " continue
                if [ "$continue" = "q" ]; then
                    break
                fi
            fi
        done < "$TEMP_FILE"
        
        echo ""
        echo "Options:"
        echo "  Enter a number to download a ROM"
        echo "  Enter 's' to search for a different ROM"
        echo "  Enter 'm' to return to the main menu"
        read -p "Your choice: " selection
        
        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -gt 0 ] && [ "$selection" -le "$count" ]; then
            local selected_rom=$(sed "${selection}q;d" "$TEMP_FILE")
            download_rom "$selected_rom" "$platform"
            
            # After download, ask if user wants to download more ROMs
            echo ""
            echo "Options:"
            echo "  1. Download another ROM"
            echo "  2. Return to main menu"
            read -p "Your choice (1 or 2): " next_action
            
            if [ "$next_action" = "2" ]; then
                break
            fi
            # If they choose 1 or anything else, continue the loop to select another ROM
            
        elif [ "$selection" = "s" ]; then
            # Ask for a new search term
            echo ""
            read -p "Enter a new search term: " new_search_term
            search_roms "$new_search_term" "$platform"
            return 0
            
        elif [ "$selection" = "m" ]; then
            # Return to main menu
            break
            
        else
            echo "Invalid selection."
        fi
    done
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
    
    # Create platform directory if it doesn't exist
    mkdir -p "$platform_dir"
    
    # URL encode the ROM file for downloading
    local encoded_rom_file=$(echo "$rom_file" | sed 's/ /%20/g')
    
    # Construct the full download URL
    local download_url="${archive_url}/${encoded_rom_file}"
    echo "Download URL: $download_url"
    
    # Download the ROM file
    curl -s -L -o "$platform_dir/$decoded_rom_name" "$download_url"
    
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
    
    if [ $? -eq 0 ]; then
        echo "Download successful!"
        echo "ROM saved to: $platform_dir/$decoded_rom_name"
    else
        echo "Error downloading ROM. Please try again."
    fi
    
    # Ask if user wants to open the destination folder
    read -p "Open destination folder? (y/n): " open_folder
    if [ "$open_folder" = "y" ] || [ "$open_folder" = "Y" ]; then
        open_roms_folder
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
    
    # Check if we're dealing with GBC platform which has .gbc files instead of .zip files
    if [ "$platform" = "gbc" ]; then
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.gbc">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
    elif [ "$platform" = "ps1" ]; then
        # PS1 platform uses .bin and .cue files
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.cue">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
    else
        # Get all zip files from the archive
        curl -s "$archive_url/" | grep -o '<a href="[^"]*\.zip">' | 
        sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
    fi
    
    # Save all ROMs before filtering
    cp "$TEMP_FILE" "${TEMP_FILE}.all"
    
    # Less restrictive platform-specific filtering
    case "$platform" in
        "nes")
            # Try to find NES-specific ROMs
            grep -i "nes\|nintendo\|famicom" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of NES ROMs, use those
            local nes_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$nes_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-NES ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "snes")
            # Try to find SNES-specific ROMs
            grep -i "snes\|super\|sfc" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of SNES ROMs, use those
            local snes_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$snes_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                # Remove obvious non-SNES games
                grep -v -i "genesis\|megadrive\|32x\|sega\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-SNES ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "genesis")
            # Try to find Genesis-specific ROMs
            grep -i "genesis\|mega\|sega\|32x\|md\|gen" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of Genesis ROMs, use those
            local genesis_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$genesis_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                # Remove obvious non-Genesis games
                grep -v -i "nintendo\|nes\|snes\|famicom\|mario\|zelda\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-Genesis ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "nintendo\|nes\|snes\|famicom\|mario\|zelda\|gameboy\|gba\|advance\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "gb")
            # Try to find GB-specific ROMs
            grep -i "gameboy\|game boy\|gb\|gbc" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of GB ROMs, use those
            local gb_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$gb_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
                # Remove GBA games
                grep -v -i "advance\|gba" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-GB ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|advance\|gba\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "gba")
            # Try to find GBA-specific ROMs
            grep -i "advance\|gba" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of GBA ROMs, use those
            local gba_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$gba_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-GBA ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "gg")
            # Try to find GG-specific ROMs
            grep -i "gamegear\|gg" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of GG ROMs, use those
            local gg_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$gg_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-GG ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "ngp")
            # Try to find NGP-specific ROMs
            grep -i "neogeo\|ngp" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of NGP ROMs, use those
            local ngp_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$ngp_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-NGP ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "sms")
            # Try to find SMS-specific ROMs
            grep -i "master system\|mastersystem\|sms" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of SMS ROMs, use those
            local sms_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$sms_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-SMS ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox\|gameboy\|gba\|advance" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "gbc")
            # Try to find GBC-specific ROMs
            grep -i "gameboy\|color\|gbc" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of GBC ROMs, use those
            local gbc_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$gbc_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-GBC ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|playstation\|ps1\|ps2\|xbox\|advance\|gba" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
        "ps1")
            # Try to find PS1-specific ROMs
            grep -i "playstation\|ps1\|psx" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
            
            # If we found a good number of PS1 ROMs, use those
            local ps1_count=$(wc -l < "${TEMP_FILE}.filtered")
            if [ "$ps1_count" -gt 50 ]; then
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            else
                # Otherwise, use all ROMs and just exclude obvious non-PS1 ones
                cp "${TEMP_FILE}.all" "$TEMP_FILE"
                grep -v -i "genesis\|megadrive\|32x\|sega\|nes\|snes\|nintendo\|gameboy\|gba\|advance\|xbox\|ps2" "$TEMP_FILE" > "${TEMP_FILE}.filtered"
                mv "${TEMP_FILE}.filtered" "$TEMP_FILE"
            fi
            ;;
    esac
    
    # Decode URL-encoded filenames
    echo "Decoding URL-encoded filenames..."
    > "${TEMP_FILE}.decoded"
    while IFS= read -r line; do
        decoded=$(urldecode "$line")
        echo "$decoded" >> "${TEMP_FILE}.decoded"
    done < "$TEMP_FILE"
    mv "${TEMP_FILE}.decoded" "$TEMP_FILE"
    
    # Count the number of results after filtering
    local count=$(wc -l < "$TEMP_FILE")
    
    if [ "$count" -eq 0 ]; then
        echo "No ROMs found for platform $(to_uppercase $platform)"
        echo "Trying alternative approach..."
        
        # Alternative approach: get all zip files and rely on user to select the right ones
        if [ "$platform" = "gbc" ]; then
            curl -s "$archive_url/" | grep -o '<a href="[^"]*\.gbc">' | 
            sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
        elif [ "$platform" = "ps1" ]; then
            curl -s "$archive_url/" | grep -o '<a href="[^"]*\.cue">' | 
            sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
        else
            curl -s "$archive_url/" | grep -o '<a href="[^"]*\.zip">' | 
            sed 's/<a href="\([^"]*\)">/\1/' > "$TEMP_FILE"
        fi
        
        # Decode URL-encoded filenames
        > "${TEMP_FILE}.decoded"
        while IFS= read -r line; do
            decoded=$(urldecode "$line")
            echo "$decoded" >> "${TEMP_FILE}.decoded"
        done < "$TEMP_FILE"
        mv "${TEMP_FILE}.decoded" "$TEMP_FILE"
        
        count=$(wc -l < "$TEMP_FILE")
        echo "Found $count total zip files in the archive"
    fi
    
    echo "Found $count ROMs for $(to_uppercase $platform) platform"
    
    # Ask for confirmation before downloading all ROMs
    read -p "Do you want to download all $count ROMs? (y/n): " confirm
    
    if [ "$confirm" != "y" ]; then
        echo "Download canceled."
        read -p "Press Enter to continue..."
        return 0
    fi
    
    # Get the correct platform directory
    local platform_dir=$(get_platform_dir "$platform")
    
    # Create platform directory if it doesn't exist
    mkdir -p "$platform_dir"
    
    echo "Downloading ROMs to $platform_dir..."
    
    # Download each ROM
    local i=1
    while read -r rom_file; do
        echo "Downloading ROM $i/$count: $rom_file"
        
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
    done < "$TEMP_FILE"
    
    echo "Download complete. $count ROMs downloaded to $platform_dir"
    
    # Ask if user wants to open the destination folder
    read -p "Open destination folder? (y/n): " open_folder
    if [ "$open_folder" = "y" ] || [ "$open_folder" = "Y" ]; then
        open_roms_folder
    fi
    
    read -p "Press Enter to continue..."
    return 0
}

# Function to verify ROM directories
verify_rom_directories() {
    echo "Verifying ROM directories..."
    
    # Check base directory
    if [ -d "$ROMS_BASE_DIR" ]; then
        echo " Base directory exists: $ROMS_BASE_DIR"
    else
        echo " Base directory does not exist: $ROMS_BASE_DIR"
        echo "Creating base directory..."
        mkdir -p "$ROMS_BASE_DIR"
        echo " Base directory created: $ROMS_BASE_DIR"
    fi
    
    # Check NES directory
    local nes_dir=$(get_platform_dir "nes")
    if [ -d "$nes_dir" ]; then
        local nes_count=$(find "$nes_dir" -type f | wc -l)
        echo " NES directory exists: $nes_dir (Contains $nes_count files)"
    else
        echo " NES directory does not exist: $nes_dir"
        echo "Creating NES directory..."
        mkdir -p "$nes_dir"
        echo " NES directory created: $nes_dir"
    fi
    
    # Check SNES directory
    local snes_dir=$(get_platform_dir "snes")
    if [ -d "$snes_dir" ]; then
        local snes_count=$(find "$snes_dir" -type f | wc -l)
        echo " SNES directory exists: $snes_dir (Contains $snes_count files)"
    else
        echo " SNES directory does not exist: $snes_dir"
        echo "Creating SNES directory..."
        mkdir -p "$snes_dir"
        echo " SNES directory created: $snes_dir"
    fi
    
    # Check Genesis directory
    local genesis_dir=$(get_platform_dir "genesis")
    if [ -d "$genesis_dir" ]; then
        local genesis_count=$(find "$genesis_dir" -type f | wc -l)
        echo " Genesis directory exists: $genesis_dir (Contains $genesis_count files)"
    else
        echo " Genesis directory does not exist: $genesis_dir"
        echo "Creating Genesis directory..."
        mkdir -p "$genesis_dir"
        echo " Genesis directory created: $genesis_dir"
    fi
    
    # Check GB directory
    local gb_dir=$(get_platform_dir "gb")
    if [ -d "$gb_dir" ]; then
        local gb_count=$(find "$gb_dir" -type f | wc -l)
        echo " GB directory exists: $gb_dir (Contains $gb_count files)"
    else
        echo " GB directory does not exist: $gb_dir"
        echo "Creating GB directory..."
        mkdir -p "$gb_dir"
        echo " GB directory created: $gb_dir"
    fi
    
    # Check GBA directory
    local gba_dir=$(get_platform_dir "gba")
    if [ -d "$gba_dir" ]; then
        local gba_count=$(find "$gba_dir" -type f | wc -l)
        echo " GBA directory exists: $gba_dir (Contains $gba_count files)"
    else
        echo " GBA directory does not exist: $gba_dir"
        echo "Creating GBA directory..."
        mkdir -p "$gba_dir"
        echo " GBA directory created: $gba_dir"
    fi
    
    # Check GG directory
    local gg_dir=$(get_platform_dir "gg")
    if [ -d "$gg_dir" ]; then
        local gg_count=$(find "$gg_dir" -type f | wc -l)
        echo " Game Gear directory exists: $gg_dir (Contains $gg_count files)"
    else
        echo " Game Gear directory does not exist: $gg_dir"
        echo "Creating Game Gear directory..."
        mkdir -p "$gg_dir"
        echo " Game Gear directory created: $gg_dir"
    fi
    
    # Check NGP directory
    local ngp_dir=$(get_platform_dir "ngp")
    if [ -d "$ngp_dir" ]; then
        local ngp_count=$(find "$ngp_dir" -type f | wc -l)
        echo " NeoGeo Pocket directory exists: $ngp_dir (Contains $ngp_count files)"
    else
        echo " NeoGeo Pocket directory does not exist: $ngp_dir"
        echo "Creating NeoGeo Pocket directory..."
        mkdir -p "$ngp_dir"
        echo " NeoGeo Pocket directory created: $ngp_dir"
    fi
    
    # Check SMS directory
    local sms_dir=$(get_platform_dir "sms")
    if [ -d "$sms_dir" ]; then
        local sms_count=$(find "$sms_dir" -type f | wc -l)
        echo " Master System directory exists: $sms_dir (Contains $sms_count files)"
    else
        echo " Master System directory does not exist: $sms_dir"
        echo "Creating Master System directory..."
        mkdir -p "$sms_dir"
        echo " Master System directory created: $sms_dir"
    fi
    
    # Check GBC directory
    local gbc_dir=$(get_platform_dir "gbc")
    if [ -d "$gbc_dir" ]; then
        local gbc_count=$(find "$gbc_dir" -type f | wc -l)
        echo " Game Boy Color directory exists: $gbc_dir (Contains $gbc_count files)"
    else
        echo " Game Boy Color directory does not exist: $gbc_dir"
        echo "Creating Game Boy Color directory..."
        mkdir -p "$gbc_dir"
        echo " Game Boy Color directory created: $gbc_dir"
    fi
    
    # Check Sega CD directory
    local segacd_dir=$(get_platform_dir "segacd")
    if [ -d "$segacd_dir" ]; then
        local segacd_count=$(find "$segacd_dir" -type f | wc -l)
        echo " Sega CD directory exists: $segacd_dir (Contains $segacd_count files)"
    else
        echo " Sega CD directory does not exist: $segacd_dir"
        echo "Creating Sega CD directory..."
        mkdir -p "$segacd_dir"
        echo " Sega CD directory created: $segacd_dir"
    fi
    
    # Check Sega 32X directory
    local sega32x_dir=$(get_platform_dir "sega32x")
    if [ -d "$sega32x_dir" ]; then
        local sega32x_count=$(find "$sega32x_dir" -type f | wc -l)
        echo " Sega 32X directory exists: $sega32x_dir (Contains $sega32x_count files)"
    else
        echo " Sega 32X directory does not exist: $sega32x_dir"
        echo "Creating Sega 32X directory..."
        mkdir -p "$sega32x_dir"
        echo " Sega 32X directory created: $sega32x_dir"
    fi
    
    # Check Saturn directory
    local saturn_dir=$(get_platform_dir "saturn")
    if [ -d "$saturn_dir" ]; then
        local saturn_count=$(find "$saturn_dir" -type f | wc -l)
        echo " Saturn directory exists: $saturn_dir (Contains $saturn_count files)"
    else
        echo " Saturn directory does not exist: $saturn_dir"
        echo "Creating Saturn directory..."
        mkdir -p "$saturn_dir"
        echo " Saturn directory created: $saturn_dir"
    fi
    
    # Check TurboGrafx-16 directory
    local tg16_dir=$(get_platform_dir "tg16")
    if [ -d "$tg16_dir" ]; then
        local tg16_count=$(find "$tg16_dir" -type f | wc -l)
        echo " TurboGrafx-16 directory exists: $tg16_dir (Contains $tg16_count files)"
    else
        echo " TurboGrafx-16 directory does not exist: $tg16_dir"
        echo "Creating TurboGrafx-16 directory..."
        mkdir -p "$tg16_dir"
        echo " TurboGrafx-16 directory created: $tg16_dir"
    fi
    
    # Check TurboGrafx-CD directory
    local tgcd_dir=$(get_platform_dir "tgcd")
    if [ -d "$tgcd_dir" ]; then
        local tgcd_count=$(find "$tgcd_dir" -type f | wc -l)
        echo " TurboGrafx-CD directory exists: $tgcd_dir (Contains $tgcd_count files)"
    else
        echo " TurboGrafx-CD directory does not exist: $tgcd_dir"
        echo "Creating TurboGrafx-CD directory..."
        mkdir -p "$tgcd_dir"
        echo " TurboGrafx-CD directory created: $tgcd_dir"
    fi
    
    # Check PlayStation directory
    local ps1_dir=$(get_platform_dir "ps1")
    if [ -d "$ps1_dir" ]; then
        local ps1_count=$(find "$ps1_dir" -type f | wc -l)
        echo " PlayStation directory exists: $ps1_dir (Contains $ps1_count files)"
    else
        echo " PlayStation directory does not exist: $ps1_dir"
        echo "Creating PlayStation directory..."
        mkdir -p "$ps1_dir"
        echo " PlayStation directory created: $ps1_dir"
    fi
    
    # Check PlayStation 2 directory
    local ps2_dir=$(get_platform_dir "ps2")
    if [ -d "$ps2_dir" ]; then
        local ps2_count=$(find "$ps2_dir" -type f | wc -l)
        echo " PlayStation 2 directory exists: $ps2_dir (Contains $ps2_count files)"
    else
        echo " PlayStation 2 directory does not exist: $ps2_dir"
        echo "Creating PlayStation 2 directory..."
        mkdir -p "$ps2_dir"
        echo " PlayStation 2 directory created: $ps2_dir"
    fi
    
    # Check Nintendo 64 directory
    local n64_dir=$(get_platform_dir "n64")
    if [ -d "$n64_dir" ]; then
        local n64_count=$(find "$n64_dir" -type f | wc -l)
        echo " Nintendo 64 directory exists: $n64_dir (Contains $n64_count files)"
    else
        echo " Nintendo 64 directory does not exist: $n64_dir"
        echo "Creating Nintendo 64 directory..."
        mkdir -p "$n64_dir"
        echo " Nintendo 64 directory created: $n64_dir"
    fi
    
    # Check Dreamcast directory
    local dreamcast_dir=$(get_platform_dir "dreamcast")
    if [ -d "$dreamcast_dir" ]; then
        local dreamcast_count=$(find "$dreamcast_dir" -type f | wc -l)
        echo " Dreamcast directory exists: $dreamcast_dir (Contains $dreamcast_count files)"
    else
        echo " Dreamcast directory does not exist: $dreamcast_dir"
        echo "Creating Dreamcast directory..."
        mkdir -p "$dreamcast_dir"
        echo " Dreamcast directory created: $dreamcast_dir"
    fi
    
    # Check Lynx directory
    local lynx_dir=$(get_platform_dir "lynx")
    if [ -d "$lynx_dir" ]; then
        local lynx_count=$(find "$lynx_dir" -type f | wc -l)
        echo " Lynx directory exists: $lynx_dir (Contains $lynx_count files)"
    else
        echo " Lynx directory does not exist: $lynx_dir"
        echo "Creating Lynx directory..."
        mkdir -p "$lynx_dir"
        echo " Lynx directory created: $lynx_dir"
    fi
    
    echo "ROM directory verification complete."
    read -p "Press Enter to continue..."
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
    local old_base_dir="$HOME/Desktop/$(whoami)/games-roms"
    local new_base_dir="$ROMS_BASE_DIR"
    
    echo "Copying ROMs from $old_base_dir to $new_base_dir..."
    
    # Check if source directory exists
    if [ ! -d "$old_base_dir" ]; then
        echo "Source directory $old_base_dir does not exist. Nothing to copy."
        read -p "Press Enter to continue..."
        return 1
    fi
    
    # Check if destination directory exists, create if not
    if [ ! -d "$new_base_dir" ]; then
        echo "Destination directory $new_base_dir does not exist. Creating it..."
        mkdir -p "$new_base_dir"
        if [ $? -ne 0 ]; then
            echo "Failed to create destination directory $new_base_dir. Please check permissions."
            read -p "Press Enter to continue..."
            return 1
        fi
    fi
    
    # Copy each platform's ROMs
    for platform in "nes" "snes" "genesis" "gb" "gba" "gg" "ngp" "sms"; do
        local src_dir="$old_base_dir/$platform"
        local dst_dir="$new_base_dir/$platform"
        
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
    
    set_roms_base_dir
    
    while true; do
        show_menu
        read -p "Enter your choice: " choice
        
        case $choice in
            1)
                clear
                echo "===== Search ROMs ====="
                echo "Available platforms: NES, SNES, Genesis, GB, GBA, GG, NeoGeo Pocket, Master System"
                select_platform
                read -p "Enter search term: " search_term
                if [ -n "$search_term" ]; then
                    clear
                    search_roms "$search_term" "$CURRENT_PLATFORM"
                fi
                ;;
            2)
                clear
                echo "===== List All ROMs ====="
                echo "Available platforms: NES, SNES, Genesis, GB, GBA, GG, NeoGeo Pocket, Master System"
                select_platform
                search_roms "" "$CURRENT_PLATFORM"
                ;;
            3)
                clear
                echo "===== Download All ROMs ====="
                echo "Available platforms: NES, SNES, Genesis, GB, GBA, GG, NeoGeo Pocket, Master System"
                echo "This will download all ROMs from the archive."
                select_platform
                read -p "Continue? (y/n): " confirm
                if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                    download_all_roms "$CURRENT_PLATFORM"
                    read -p "Press Enter to continue..."
                fi
                ;;
            4)
                clear
                echo "===== Open ROMs Folder ====="
                select_platform
                open_roms_folder
                read -p "Press Enter to continue..."
                ;;
            5)
                clear
                echo "===== Verify ROM Directories ====="
                verify_rom_directories
                ;;
            6)
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
trap "rm -f $TEMP_FILE" EXIT

# Start the main menu
main_menu
