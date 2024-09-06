#!/bin/bash

# Set the paths
SITE_PACKAGES="venv/lib/python*/site-packages"
ROOT_DIR="$(pwd)"
ZIP_FILE="project_package.zip"
TEMP_DIR="package_temp"

EXCLUDE_PACKAGES=("setuptools" "setuptools-73.0.1.dist-info" "pip" "pip-21.2.4.dist-info")

# Create a temporary directory to collect the files
mkdir -p $TEMP_DIR

# Create a temporary directory to collect the files
mkdir -p $TEMP_DIR

# Function to check if a package is in the exclude list
function is_excluded() {
    for package in "${EXCLUDE_PACKAGES[@]}"; do
        if [[ "$1" == *"$package"* ]]; then
            return 0 # True (package is excluded)
        fi
    done
    return 1 # False (package is not excluded)
}

# Copy all site-packages to the temporary directory, excluding unwanted packages
echo "Copying site-packages to $TEMP_DIR..."
for dir in $SITE_PACKAGES/*; do
    if ! is_excluded "$dir"; then
        cp -r "$dir" $TEMP_DIR/
    else
        echo "Skipping package: $dir"
    fi
done

# Copy all Python files from the root directory to the temporary directory
echo "Copying Python files from the root directory to $TEMP_DIR..."
find $ROOT_DIR -maxdepth 1 -name "*.py" -exec cp {} $TEMP_DIR/ \;

# Create a ZIP file containing all the files from the temporary directory
echo "Creating zip file $ZIP_FILE..."
zip -r $ZIP_FILE $TEMP_DIR/*

# Cleanup the temporary directory
echo "Cleaning up..."
rm -rf $TEMP_DIR

echo "Done! ZIP file created: $ZIP_FILE"