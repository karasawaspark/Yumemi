# 天気アプリ
![Simulator Screen Recording - iPhone 14 Pro - 2024-02-27 at 14 14 11](https://github.com/karasawaspark/Yumemi/assets/156158259/87c2601a-1a14-427b-96b9-8ed09a9cf5c9)

<br>【概要】
<br>画面１：TableViewによりパッケージ化したAPIを読み込む
<br>画面２：TableViewで選んだ地域のデータの詳細画面を表示
<br>　　　　（「Reload」を押すとデータの更新をする）
<br>※ 各地の天気結果はあらかじめAPIに含まれているもの

<br>【詳細】
<br>・処理中のindicaterの画面表示
<br>・delegateを使った画面遷移
<br>・APIから受け取ったJSONデータの取得

<br>【工夫したところ】
<br>・JSONデータを読み込む際は、読み込みを別ファイルで行いコードの可読性を上げた
<br>・structを使用し、可能な限りスコープを絞ったコーディングを心がけた
