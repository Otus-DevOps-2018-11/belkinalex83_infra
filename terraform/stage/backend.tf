terraform {
  backend "gcs" {
    bucket = "storage-bucket-reddit"
    prefix = "stage"
  }
}
