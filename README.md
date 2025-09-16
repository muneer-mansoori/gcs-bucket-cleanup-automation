# GCS Bucket Cleanup for S3-to-GCS Migration

A simple bash script to automate Google Cloud Storage (GCS) bucket cleanup before migrating data from AWS S3.

## Overview

During cloud migrations from AWS S3 to Google Cloud Storage, it's crucial to ensure destination buckets are clean to avoid conflicts and ensure data integrity. This script automates the cleanup process by reading S3-to-GCS URL mappings and clearing the corresponding GCS directories.

## Features

- ✅ Batch cleanup of multiple GCS buckets/directories
- ✅ Input validation for S3 URL format
- ✅ Parallel processing with `gsutil -m` for faster operations
- ✅ Graceful error handling for non-existent directories
- ✅ Comprehensive logging for audit trails
- ✅ Automatic URL normalization

## Prerequisites

- **Google Cloud SDK**: Install and configure `gsutil`
- **Authentication**: Authenticate with Google Cloud using `gcloud auth login`
- **Permissions**: Ensure your account has delete permissions on target GCS buckets

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/s3-gcs-migration.git
cd s3-gcs-migration
```

2. Make the script executable:
```bash
chmod +x cleanup_gcs_buckets.sh
```

## Usage

1. Create a mapping file with S3 and GCS URL pairs (space-separated):
```
s3://source-bucket/path1 gs://destination-bucket/path1
s3://source-bucket/path2 gs://destination-bucket/path2
```

2. Update the script to point to your mapping file:
```bash
# Edit the last line in cleanup_gcs_buckets.sh
done < "/path/to/your/mapping/file"
```

3. Run the cleanup script:
```bash
./cleanup_gcs_buckets.sh
```

## Input File Format

The mapping file should contain one S3-to-GCS URL pair per line:
```
s3://my-s3-bucket/folder1 gs://my-gcs-bucket/folder1
s3://my-s3-bucket/folder2 gs://my-gcs-bucket/folder2
```

- Lines with invalid S3 URLs are automatically skipped
- Empty lines are ignored
- GCS URLs are automatically normalized with trailing slashes

## Example Output

```
Cleaning up contents of GCS directory: gs://my-gcs-bucket/folder1/
Contents deleted from: gs://my-gcs-bucket/folder1/
Cleaning up contents of GCS directory: gs://my-gcs-bucket/folder2/
No files to delete or directory doesn't exist: gs://my-gcs-bucket/folder2/
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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please [open an issue](https://github.com/yourusername/s3-gcs-migration/issues).
