# S3-to-GCS Migration Toolkit

Automation scripts for AWS S3 to Google Cloud Storage migration with GCS bucket cleanup and transfer job creation.

## Overview

This toolkit provides essential scripts for S3-to-GCS migration:
1. **GCS Cleanup**: Clean destination buckets before migration
2. **Transfer Job Creation**: Create Google Cloud Transfer Service jobs for automated migration

## Features

- ✅ **GCS Bucket Cleanup**: Batch cleanup with parallel processing
- ✅ **Transfer Job Creation**: Automated Google Cloud Transfer Service jobs
- ✅ **Input Validation**: S3 URL format verification
- ✅ **Error Handling**: Graceful handling of non-existent resources
- ✅ **Audit Logging**: Comprehensive operation tracking
- ✅ **URL Normalization**: Automatic trailing slash handling

## Prerequisites

- **Google Cloud SDK**: Install and configure `gcloud` and `gsutil`
- **Authentication**: Authenticate with Google Cloud using `gcloud auth login`
- **APIs**: Enable Google Cloud Transfer Service API
- **Permissions**: 
  - GCS: Delete permissions on target buckets
  - Transfer Service: Create and manage transfer jobs

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/s3-gcs-migration.git
cd s3-gcs-migration
```

2. Make scripts executable:
```bash
chmod +x cleanup_gcs_buckets.sh
chmod +x create_transfer_jobs.sh
```

## Usage

### 1. Setup Configuration Files

Edit the `bucket_urls.txt` file with your S3 and GCS URL pairs:
```
s3://source-bucket/path1 gs://destination-bucket/path1
s3://source-bucket/path2 gs://destination-bucket/path2
```

Update `aws-creds.json` with your AWS credentials:
```json
{
  "accessKeyId": "YOUR_AWS_ACCESS_KEY_ID",
  "secretAccessKey": "YOUR_AWS_SECRET_ACCESS_KEY"
}
```

### 2. Clean GCS Buckets (Optional)
Clean destination buckets before migration:
```bash
./cleanup_gcs_buckets.sh
```

### 3. Create Transfer Jobs
Create Google Cloud Transfer Service jobs:
```bash
./create_transfer_jobs.sh
```

## Input File Format

The `bucket_urls.txt` file should contain one S3-to-GCS URL pair per line:
```
s3://my-s3-bucket/folder1 gs://my-gcs-bucket/folder1
s3://my-s3-bucket/folder2 gs://my-gcs-bucket/folder2
```

- Lines with invalid S3 URLs are automatically skipped
- Empty lines are ignored
- GCS URLs are automatically normalized with trailing slashes

## Example Outputs

**GCS Cleanup:**
```
Cleaning up contents of GCS directory: gs://my-gcs-bucket/folder1/
Contents deleted from: gs://my-gcs-bucket/folder1/
Cleaning up contents of GCS directory: gs://my-gcs-bucket/folder2/
No files to delete or directory doesn't exist: gs://my-gcs-bucket/folder2/
```

**Transfer Job Creation:**
```
Creating transfer job for: s3://source-bucket/data/ -> gs://dest-bucket/data/
Transfer job created successfully: projects/my-project/transferJobs/12345
```

## Safety Considerations

⚠️ **Important**: This script permanently deletes data from GCS buckets.

- Always test with a small subset first
- Keep backups before running cleanup
- Use IAM roles with minimal required permissions
- Review the mapping file carefully before execution

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Create a Pull Request
