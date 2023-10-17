#!/bin/bash

# Author: JohnLavery
# Date: 10/17/23
# Description: A Bash script to run Volatility plugins on a memory dump file to eliminate some manual tasks.
# Usage: ./volscript.sh <memory file>
#        Ex: ./volscript.sh memory_dump.bin

# Check for the required argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <memory_dump_file>"
    exit 1
fi

# Get the memory dump file path from the command-line argument
MEMORY_DUMP="$1"

# Define the list of plugins to run
PLUGINS=("cmdline" "filescan" "pstree" "pslist" "malfind" "netscan")

# Loop through the plugins and run Volatility for each
for plugin in "${PLUGINS[@]}"; do
    OUTPUT_FILE="volatility_${plugin}_output.txt"
    vol -f "$MEMORY_DUMP" windows."$plugin" > "$OUTPUT_FILE"
    echo "Ran plugin $plugin, output saved to $OUTPUT_FILE"
done
