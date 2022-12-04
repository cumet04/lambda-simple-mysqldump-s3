# lambda-simple-mysqldump-s3
mysqldumpをs3に投げるスクリプトを、EC2でやっていたようなシンプルなコマンドで、でもlambdaで実現しようとするサンプル

解説記事: https://zenn.dev/cumet04/articles/lambda-mysqldump-s3

## アプローチ
lambdaのカスタムランタイム（docker image）でmysqldumpとgzipとawscliをインストールしたイメージを使い、shell scriptでサクッと投げる

## ローカルテスト方法
※ローカルとはいいつつ、AWSの実リソース（S3, SSM）も使う

1. docker compose upする（lambda部分が失敗する）
2. `cat make-dummy.sql | docker compose exec -T db mysql -ppassword`
3. アップロード先のS3バケットを作り、`task/functino.sh`のs3 cpコマンドのバケットを書き換える
4. `task/function.sh`のコマンドを見ながらSSMパラメータストアのパラメータを作る
5. docker compose downしてから再度upする（`docker compose up --attach lambda --attach invoker`すると見やすい）
6. 成功すればS3にファイルが作られる
