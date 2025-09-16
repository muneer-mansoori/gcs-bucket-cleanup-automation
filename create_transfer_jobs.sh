#!/bin/bash

# =============================================================================
# Google Cloud Transfer Service Job Creation Script
# =============================================================================
# Purpose: Create Google Cloud Transfer Service jobs for S3-to-GCS migration
# Input: File containing S3 and GCS URL pairs (space or tab-separated)
# Usage: ./create_transfer_jobs.sh
# Prerequisites: 
#   - gcloud CLI installed and authenticated
#   - aws-creds.json file with AWS credentials
#   - Transfer Service API enabled in GCP project
# =============================================================================

# Read the mapping file line by line and create transfer jobs
# Expected format: s3://bucket/path gs://bucket/path (space or tab separated)
while IFS=$'\t' read -r s3_url gcs_url; do
    
    # Input validation: Skip empty lines and ensure both URLs are present
    if [[ -n "$s3_url" && -n "$gcs_url" ]]; then
        
        # Normalize URLs by ensuring they end with trailing slashes
        # This ensures we're transferring directory contents properly
        [[ "$s3_url" != */ ]] && s3_url="$s3_url/"
        [[ "$gcs_url" != */ ]] && gcs_url="$gcs_url/"
        
        # Log the transfer job creation for audit trail
        echo "Creating transfer job for: $s3_url -> $gcs_url"
        
        # Create Google Cloud Transfer Service job with the following options:
        # --source-creds-file: JSON file containing AWS access credentials
        # --project: GCP project ID where the transfer job will be created
        # --overwrite-when=always: Overwrite existing files in destination
        gcloud transfer jobs create "$s3_url" "$gcs_url" \
            --source-creds-file=aws-creds.json \
            --project=lk-prod-apps \
            --overwrite-when=always
    fi
    
# Read from the bucket URLs mapping file
done < "bucket_urls.txt"
