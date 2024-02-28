# 天気アプリ
![Simulator Screen Recording - iPhone 14 Pro - 2024-02-27 at 14 14 11](https://github.com/karasawaspark/Yumemi/assets/156158259/87c2601a-1a14-427b-96b9-8ed09a9cf5c9)

<br>【概要】
<br>画面１：TableViewにAPIから引き抜いた地域情報を取得する
<br>画面２：TableViewで選んだデータを引き継ぎ、地域など詳細データを表示
<br>（「Reload」を押すとデータの更新をする）
<br>※各地の天気結果はあらかじめAPIに含まれているもの

<br>【ポイント】
<br>・delegateを使った画面データの引き継ぎ
<br>・APIおよびJSONデータの取得
<br>・async、awaitによる非同期処理

<br>【工夫したところ】
<br>・JSONデータ読み込みを別ファイルで行うことで、コードの可読性を上げた
<br>・可能な限りスコープを絞ったシンプルな記述を心がけた
