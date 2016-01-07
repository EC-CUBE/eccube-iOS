# eccube-iOS

Sample app for EC-CUBE hosted online shops.  
Easily customized & ulilized for the owned shops.  
Also, implements Push Notification receiver to fully  
maximize the potential of mobile shoppers.

## 目次

- [このアプリについて](#このアプリについて)
  - [概要](#概要)
  - [使い方](#使い方)
- [アプリをカスタマイズする](#アプリをカスタマイズする)
  - [Identifierを変更する](#Identifierを変更する)
  - [運営しているEC-CUBEのショップのURLを設定する](#運営しているEC-CUBEのショップのURLを設定する)
  - [スプラッシュ画像を変更する](#スプラッシュ画像を変更する)
  - [アイコン画像を変更する](#アイコン画像を変更する)
  - [メニュー画像を変更する](#メニュー画像を変更する)
  - [プッシュ受信の設定を変更する](#プッシュ受信の設定を変更する)
  - [p12証明書を設定する](#p12証明書を設定する)


## このアプリについて

### 概要

EC-CUBE3系で運営するショップを Android のアプリとして連携することができます

プッシュ通知を受信するための例として [「Appiaries プッシュ通知プラグイン」](http://www.ec-cube.net/products/detail.php?product_id=1030) を用いた仕組みを実装していますが、それ以外のサービスを利用することも可能です。

### 使い方

xcode プロジェクトです。git clone でローカルにソースコードを展開して下さい。

## アプリをカスタマイズする

カスタマイズは、アプリで具現化したい内容によって異なりますが、ここではカスタマイズする上で **いちばん基本的な箇所についてその主要なポイントと注意点** を説明します。

### Identifierを変更する

Bundle Identifier の変更は xcode に一般的な方法でおこなわれますが、以下に作業の流れを要約します。

1. xcode でプロジェクトを選択します。
2. 右上にある Identity and Type で新しいプロジェクト名を指定します。
3. 差分が表示されるので Rename を押下します。
4. Product > Scheme > Manage Schemes を開き、Name に新しいプロジェクト名を指定して OK を押下します。
5. 左上の + を押下し、新しいプロジェクト名を追加します。
6. View > Navigators > Show Project Navigator を開き、Target を選択します。
7. General タブを開きます。
8. Bundle Identifier を変更します。

### 運営しているEC-CUBEのショップのURLを設定する

アプリと連携するショップの URL を設定します。

1. WebViewController.m を開きます。
2. kDefaultStartUrl にすでに設定されている www.ec-cube.net を店舗のウェブサイトの URL に書き換えます。

### スプラッシュ画像を変更する

スプラッシュ画像は Assets.xcassets/LaunchImage.launchimage に置いてあります。  
解像度にあわせた画像を配置してください。

### アイコン画像を変更する

アイコン画像は Assets.xcassets/AppIcon.appiconset に置いてあります。  
解像度にあわせた画像を配置してください。

### メニュー画像を変更する

メニュー画像はそれぞれ以下に置いてあります。  
Assets.xcassets/tab_cart.imageset  
Assets.xcassets/tab_cart_on.imageset  
Assets.xcassets/tab_favorite.imageset  
Assets.xcassets/tab_favorite_on.imageset  
Assets.xcassets/tab_home.imageset  
Assets.xcassets/tab_home_on.imageset  
Assets.xcassets/tab_list.imageset  
Assets.xcassets/tab_list_on.imageset  
Assets.xcassets/tab_user.imageset  
Assets.xcassets/tab_user_on.imageset  
解像度にあわせた画像を配置してください。

### プッシュ受信の設定を変更する

運営しているEC-CUBE3系のショップに、[「Appiaries プッシュ通知プラグイン」](http://www.ec-cube.net/products/detail.php?product_id=1030) を利用することで、簡単にプッシュ通知に対応することができます。

* アピアリーズとの連携の設定が別途必要です
* プッシュ通知の配信や受信は他のサービスを利用して実装することも可能です。

GCM とアピアリーズに登録し、それぞれの情報をプラグインに設定する方法については[「Appiaries プッシュ通知プラグイン」](http://www.ec-cube.net/products/detail.php?product_id=1030) をインストールした後でプラグインの「設定」ページに詳細がありますのでそちらを参照して下さい。  

プラグインの設定の完了後、本アプリがアピアリーズと連携するための値は  AppDelegate.m に記述します。

1. AppDelegate.m を開きます。
2. アピアリーズで契約した**「データストア ID」**を baas.config.datastoreID 設定します。
3. アピアリーズで登録した**「アプリ ID」**を baas.config.applicationID 設定します。
4. アピアリーズで登録したアプリの**「アプリトークン」**を baas.config.applicationToken 設定します。
5. その他、ソース上の//@FIXME:で書いているソースのコメントアウトを外します。


### p12証明書を設定する

プロジェクトをビルドするには p12証明書が必要です。 
Apple Developer サイトでの cer ファイル取得、キーチェーンアクセスでの p12 証明書の登録については、一般的な方法にしたがってください。
