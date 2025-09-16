#!/bin/bash

# =============================================================================
# GCS Bucket Cleanup Script for S3-to-GCS Migration
# =============================================================================
# Purpose: Clean up GCS bucket contents before migrating data from AWS S3
# Input: File containing S3 and GCS URL pairs (space-separated)
# Usage: ./cleanup_gcs_buckets.sh
# Prerequisites: gsutil must be installed and authenticated
# =============================================================================

# Read the mapping file line by line and cleanup corresponding GCS buckets
# Expected format: s3://bucket/path gs://bucket/path
while read -r s3_url gcs_url; do
    # Input validation: Skip empty lines and ensure both URLs are present
    # Also verify that the first URL is a valid S3 URL format
    if [[ -n "$s3_url" && -n "$gcs_url" && "$s3_url" == s3://* ]]; then
        
        # Normalize GCS URL by ensuring it ends with a trailing slash
        # This ensures we're targeting the directory contents, not the directory itself
        [[ "$gcs_url" != */ ]] && gcs_url="$gcs_url/"
        
        # Log the cleanup operation for audit trail
        echo "Cleaning up contents of GCS directory: $gcs_url"
        
        # Execute cleanup using gsutil with the following options:
        # -m: Enable parallel processing for faster operations
        # rm -r: Recursively remove all contents
        # 2>/dev/null: Suppress error messages for non-existent paths
        # Use && and || for conditional success/failure messaging
        gsutil -m rm -r $gcs_url 2>/dev/null && \
            echo "Contents deleted from: $gcs_url" || \
            echo "No files to delete or directory doesn't exist: $gcs_url"
    fi
done < "bucket_urls.txt"
