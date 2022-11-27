# lambda-simple-mysqldump-s3
mysqldumpをs3に投げるスクリプトを、EC2でやっていたようなシンプルなコマンドで、でもlambdaで実現しようとするサンプル

作業ログ: https://zenn.dev/cumet04/scraps/7565b6533cc806

## アプローチ
lambdaのカスタムランタイム（docker image）でmysqldumpとgzipとawscliをインストールしたイメージを使い、shell scriptでサクッと投げる

## ローカルテスト方法
※ローカルとはいいつつ、AWSの実リソース（S3, SSM）も使う

1. docker compose upする（lambda部分が失敗する）
2. `cat make-dummy.sql | docker compose exec -T db mysql -ppassword`
3. アップロード先のS3バケットを作り、`task/functino.sh`のs3 cpコマンドのバケットを書き換える
4. `runtime/bootstrap`のコマンドを見ながらSSMパラメータストアのパラメータを作る
5. docker compose downしてから再度upする（`docker compose up --attach lambda --attach invoker`すると見やすい）
6. 成功すればS3にファイルが作られる

## AWS実行環境の作成
lambda実行docker imageは適当にECRのリポジトリを作ってpushしておく。Dockerfileのものがそのまま動く想定。

lambdaがS3やSSMと通信するため、NATゲートウェイやVPCエンドポイントを必要に応じて作っておく。

lambdaをVPC配置＆docker imageで作成する
