#!/bin/bash
: <<'END'
This software was created by United States Government employees at 
The Center for Cybersecurity and Cyber Operations (C3O) 
at the Naval Postgraduate School NPS.  Please note that within the 
United States, copyright protection is not available for any works 
created  by United States Government employees, pursuant to Title 17 
United States Code Section 105.   This software is in the public 
domain and is not subject to copyright. 
END
#
# Script to run prior to grading a student's lab.  It is intended
# for two potential purposes:
# 1) Create solution artifacts to campare against student artifacts;
# 2) Process student artifacts into a different form, e.g., extracting
#    browser sqlite data as in the default instance of this file below.
# 
# 
#


# Path to the directory containing the files
directory="$HOME"

# Iterate over each file in the directory
for file in "$directory"/*; do
    if [[ -f "$file" ]]; then  # Check if it's a regular file
        # Remove non-ASCII characters from the file and overwrite it
        tr -cd '\11\12\15\40-\176' < "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    fi
done


#
#  Add other processing below.
#

