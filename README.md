# JSYS ATTEND
jsys slack botです。  
主に情報システム局のSlack内で各種出席を取ります。  
愛嬌あるのでかわいがってあげてください。

## 出席
たぶんこれがこいつの生きる目的。各種コマンドで100程度のイベントに対して出席をとることが可能です。

### 出席の開始
```
@attendbot: 出席 [イベント名や詳細]
```
にて新しくイベントの出席を作成をすることができます。  
![出席.png](https://raw.github.com/wiki/everysick/jsys-attend/images/attend-1.png)  
attendちゃんは作成が成功するとチャンネルの番号を返してくれるので、基本的にそれを使用して出欠を取ります。

### 出席の締切
```
@attendbot: 締切 [Ch番号]
```
にてイベントの出欠を締め切ることができます。  
締め切ったあとには誰が出席するのかの一覧と、出席する人数を取得できます。  
![締切.png](https://raw.github.com/wiki/everysick/jsys-attend/images/attend-2.png)  
イベントの出欠をし終わったあとは必ず締め切るようにしてください。

### 出席、欠席の方法
出席、欠席は以下のようにチャンネルを指定して決めることができます。
```
@attendbot: 出 [Ch番号]
```
![出.png](https://raw.github.com/wiki/everysick/jsys-attend/images/attend-3.png)  

```
@attendbot: 欠 [Ch番号]
```
![欠.png](https://raw.github.com/wiki/everysick/jsys-attend/images/attend-4.png)  
また、一度出欠を決めた後でも上書きが可能です。

### 一覧の取得
現在出欠確認中のイベント一覧を取得することが出来ます。  
```
@attendbot: 一覧
```
![一覧.png](https://raw.github.com/wiki/everysick/jsys-attend/images/attend-5.png)  
チャンネル名が不明なとき、遡るのが面倒な時に使ってください。

### 特定のチャンネルの状態
チャンネル名を指定することでイベントの出欠状況を取得することができます。
この場合は締切と違い、チャンネルが閉じられることはありません。  
```
@attendbot: 状態 [Ch番号]
```
![状態.png](https://raw.github.com/wiki/everysick/jsys-attend/images/attend-6.png)  


## 会話
docomo APIを使用して適当な会話ができます。  
アットマーク(@)付きで話しかけてみてね。
