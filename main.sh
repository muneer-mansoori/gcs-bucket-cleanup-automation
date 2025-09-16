#!/bin/bash

# Read the file and cleanup GCS buckets before transfer
while read -r s3_url gcs_url; do
    # Skip empty lines and invalid entries
    if [[ -n "$s3_url" && -n "$gcs_url" && "$s3_url" == s3://* ]]; then
        # Add trailing slash if not present
        [[ "$gcs_url" != */ ]] && gcs_url="$gcs_url/"
        
        echo "Cleaning up contents of GCS directory: $gcs_url"
        gsutil -m rm -r $gcs_url 2>/dev/null && echo "Contents deleted from: $gcs_url" || echo "No files to delete or directory doesn't exist: $gcs_url"
    fi
done < "/Users/muneer.mansoori/Documents/s3-gcs-migration/new"
