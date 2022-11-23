function handler () {
  filename=$(date '+%Y-%m-%d_%H%M%S').sql.gz

  mysqldump -u root -h db db | \
    gzip | \
    aws s3 cp - s3://sbox-lambda-simple-mysqldump-s3/dump/$filename

  echo $filename
}
