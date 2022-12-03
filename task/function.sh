# オプションが長すぎるので関数にしてわかりやすくする
function getparam() {
  aws ssm get-parameter --with-decryption --region ap-northeast-1 --name $1 --query 'Parameter.Value' --output text
}
export DBUSER=$(getparam sbox-mysqldump-dbuser)
export DBHOST=$(getparam sbox-mysqldump-dbhost)
export DBNAME=$(getparam sbox-mysqldump-dbname)
export DBPASS=$(getparam sbox-mysqldump-dbpass)

function handler () {
  filename=$(date '+%Y-%m-%d_%H%M%S').sql.gz

  mysqldump -u $DBUSER -h $DBHOST $DBNAME -p$DBPASS | \
    gzip | \
    aws s3 cp - s3://sbox-lambda-simple-mysqldump-s3/dump/$filename

  echo $filename
}
