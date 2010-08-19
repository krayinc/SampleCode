ASIHTTPRequest sample
=====================

ASIHTTPRequest をリポジトリに含めていないため、そのままではビルドできません。
http://github.com/pokeb/asi-http-request/tree からダウンロードして、プロジェクトに追加してください。

実行時に S3 にアクセスするため、アカウントの設定をする必要があります。
Xcode のプロジェクトツリーから「実行可能ファイル」→「ASIHTTPRequest」をダブルクリックして、引数タブの環境変数に以下の二つを設定してください。

  * S3_ACCESS_KEY
    値に S3 のアクセスキーを設定

  * S3_SECRET_ACCESS_KEY
    値に S3 のシークレットアクセスキーを設定
