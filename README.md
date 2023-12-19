# bookreview
​
## サイト概要
### サイトテーマ
本を検索して、本を評価したり、他人の評価を見ることができるレビューサイト。
​
### テーマを選んだ理由
売れている本を読んでみても、好みでない、中身が薄いなど、失敗したと感じることがよくあります。
目的に合った本を選ぶのは、結構難しく、失敗して時間を無駄にしたと思うことがないようにしたいと思いました。
本の評価、ジャンルなどが分かれば読書が充実すると考えました。

​
### ターゲットユーザ
・本を購入する前に本の評価が知りたい人  
・本の感想を共有したいひと
​
### 主な利用シーン
・本の購入前に、どんな本か知りたいとき  
・他の人に本を進めたいとき
​
## 機能一覧
・ユーザー登録(devise)
　・ログイン機能(devise)
　・退会機能
・管理者機能
・投稿機能
　・5段階評価機能(Raty)
　・タグ機能
・コメント機能
・ページネーション機能(kaminari)
・楽天ブックス書籍検索API機能
・検索機能(楽天書籍検索、投稿検索、タグ検索)
​
## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

