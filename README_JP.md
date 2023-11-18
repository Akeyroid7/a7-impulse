# Assetto Corsa: トリガー振動アプリ「A7-Impulse」

[![Version](https://img.shields.io/badge/Version-0.0_(Experimental)-blue.svg)](https://github.com/Akeyroid7/a7-impulse/releases)
[![Compatibility](https://img.shields.io/badge/CSP-0.2.0-green.svg)](https://acstuff.ru/patch/#0.2.0)

[![Banner](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Xbox-One-Console-wController-FL.jpg/2560px-Xbox-One-Console-wController-FL.jpg)](https://ja.wikipedia.org/wiki/Xbox_One#/media/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Xbox-One-Console-wController-FL.jpg)

## アセットコルサ、遂に「インパルストリガー」と出会う。

通称「箱コン」と呼ばれるXboxのコントローラーですが、2013年11月22日に発売されたXbox One[^1]の時代から、左右のトリガーに振動モーターが内蔵されているのをご存知でしょうか？

この「インパルストリガー」と名付けられた振動トリガーは、現行のXboxシリーズにも引き継がれていて、実はWindowsのAPIからも利用できるようになっています（ただしUSB接続に限る。Bluetooth接続では利用できません。 [Windows 用 Xbox ワイヤレス アダプター](https://www.xbox.com/ja-JP/accessories/adapters/wireless-adapter-windows) なるものを用意すれば無線でも利用できるようですが、恐らく現在は入手困難だと思います）

しかし、この機能に対応したPCソフトは極端に少なく、Xbox版ではトリガー振動に対応しているという噂のあるソフトでもPC版ではインパルストリガーが動作しないということはザラで、私は今までに [Microsoftストア版のForza Horizon 4 Demo](https://www.xbox.com/ja-JP/games/store/forza-horizon-4/9p8cp1l72jxs) でしかトリガー振動が動作しているのを見たことがありません。APIバージョンの都合でUWPアプリでしか利用できないなんて噂も耳にしていました（しかし実際のところ噂は誤りだったようで、とりあえず通常の振動と同時に作動させることのできるユーティリティアプリは幾つか存在していたようです）

アセットコルサも例外ではなく、2013年11月8日にSteamで早期リリース版が公開[^2]されて以来、現在に至るまでインパルストリガーは利用できなかったわけなのですが……

はい、あのCSP開発陣がまた[^3]革命を起こしました。CSP v0.2.0では、振動トリガーをLuaから制御できるようになっています。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Foooooooooooooooooooooooooooooo!!!!!<br><br>CSP開発者は天才！！<br>CSP開発者は天使！！<br>CSP開発者を崇めよ！！ <a href="https://t.co/0n0tqtIp9M">pic.twitter.com/0n0tqtIp9M</a>

![Twitter](https://pbs.twimg.com/media/F-4NTcPbMAAsDdc?format=png&name=small)

</p>&mdash; キノ🍀（あっきー@きゃらくたぁ製作所） (@Akeyroid7) <a href="https://twitter.com/Akeyroid7/status/1724330571026080217?ref_src=twsrc%5Etfw">November 14, 2023</a></blockquote>

もう発狂したよね。DualSenseのアダプティブトリガーに対応するぐらいだから「この調子で箱コンの振動トリガーも使えるようにしてくんないかなー」なんて淡い期待を抱いたりしてたんですが。CSP開発陣は見事その期待に答えてくれちゃったわけです。

ありがとう……　マジで有り難う……

同じ年、同じ季節に現れた「インパルストリガー」と「Steam版アセットコルサ」は、なんと10年の時を経て、CSPというMODのアップデートにより**奇跡の出会い**を果たしたわけです。なんだかロマンチックですね。涙が止まりません。

[^1]:日本国内向けに発売されたのは2014年9月4日だそうです。[Wikipedia](https://wikipedia.org/wiki/Xbox_One)
[^2]:[Wikipedia (英語版)](https://wikipedia.org/wiki/Assetto_Corsa)
[^3]:私にとって初めての革命は [Gamepad FX](https://www.racedepartment.com/downloads/a7-assist-gamepad-fx.53941/) でしたが、皆さんご存知の通りCSPはアセットコルサに数々の革命を起こしています。

## このアプリについて

このLuaアプリをインストールすると、コントロール設定が「Xbox 360ゲームパッド」に設定されていて、尚且つSteam入力が無効になっている場合に限り、対応コントローラーのインパルストリガーが振動します。CSP v0.2.0の新機能を利用しているため、v0.1.79以前のCSPには非対応です。PSコンやプロコンなど箱コン以外に対しては何もしません。一応、非対応環境でもエラーが出ないような仕組みにしているつもりなので、万が一エラーが発生していたら教えてください。

トリガー振動はアクセルとブレーキどちらでも作動します。エフェクトはタイヤのスリップ量とグリップ限界の比率（ndSlip）に基づいていて、スリップ方向や四輪の荷重バランス、摩擦円の変形などを考慮に加えています。ABSの動作にも反応します。

とりあえず動くようにしただけの試験的スクリプトなので、GUIや調整機能はありません。調整が必要であれば`apps\lua\A7-Impulse\xbox_trigger.lua`を編集してください。わからないことがあれば [Twitter DM](https://twitter.com/messages/compose?recipient_id=843026057154318337) または [Discord](https://discord.gg/dgsVUdEyVA) まで。

トリガー振動を無効化したい場合は、コンテンツマネージャーの「コンテンツ」欄から「その他」->「LUA APPS」を開き、下の方の「無効」を押して下さい。もしくは`apps\lua`内の`A7-Impulse`フォルダを`apps\lua-off`に移動させても同じ結果が得られます。

このLuaアプリはCSPに新しく追加された「Lua Appsと独立して物理フレームレート（333Hz）で別のスクリプトを動作させる機能」を活用し、Gamepad FXには干渉せずに動作するようになっています。

今後は反響次第で、INIファイルやGUIで設定を変更する機能や、Gamepad FXとの連帯機能などを計画しています。

## インストール方法

このMODの利用には、事前に [**Content Manager**](https://assettocorsa.club/content-manager.html) と [**Custom Shaders Patch**](https://acstuff.ru/patch/) のセットアップが必須です！

セットアップ済みの方は以下の手順だけでインストール完了です。

+ [Releases](https://github.com/Akeyroid7/a7-impulse/releases) から最新版をダウンロードしてください
+ ダウンロードしたZIPの中から`assettocorsa`フォルダを開き`apps`フォルダをSteamライブラリ内の`assettocorsa`フォルダにドラッグアンドドロップしてください

## サポート

私は本職のプログラマーではないので、好ましいLuaスクリプトの書き方が出来ているかは正直わかりません。GitHubも初めて使いました。

もし、此処はもっとこうしたほうが良いとか、何かしらのご意見ご感想等ありましたら、ご気軽に [Twitter](https://twitter.com/Akeyroid7) や [X.com](https://x.com/Akeyroid7) のDM、もしくは [こちらのDiscordサーバー](https://discord.gg/dgsVUdEyVA) でコメント頂ければ幸いです。

また [PayPal.me](https://paypal.me/Akeyroid7) にて、寄付を受け付けています。デフォルト設定はドルになっていますが日本円も利用できるので、よかったらDualSense購入のためにお小遣いください……

---

&copy; 2023 Akeyroid7 &bull; [MIT License](https://gh.io/mit)