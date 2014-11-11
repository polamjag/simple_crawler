# なんこれ

* google custom searchを利用した簡単なクローラです

# 依存ライブラリ

```ruby
require 'json'  
require 'nokogiri'  
require 'sqlite3'  
require 'open-uri'  
```  
です。gem installでインストールしてください。


# 使い方

* google custom searchのAPIキーを取得する(参照: [offsidenowの日常を綴ったブログ](http://offsidenow.phpapps.jp/archives/415))

* ```git clone git@github.com:matsunoki/crawler_ruby.git```

* クローンしたリポジトリの中の__googleapi\_password.rb.default__を__googleapi\_password.rb__とする

* エディタで__googleapi\_password.rb__を開き、api_keyとcxを編集する

* ```ruby crawler.rb 検索キーワード ディレクトリ名 ```と実行

* データベースに検索キーワードについてGoogle検索した結果の(title, url)が保存されます

# ライセンス

* MITライセンスに準拠します

