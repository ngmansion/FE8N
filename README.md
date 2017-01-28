https://github.com/ngmansion/FE8N/releases/download/20170125/FE8N.ips

##改造法の解説
http://wp.me/p5MjVV-Z8
# 変更メモ
##ステータス
HPの上限は、クラスHP上限を参照します  
ただし敵将はクラスHP上限が80未満でも80まで引き上げられます

敵のステータスは上限突破させています  
味方はしてません

##システム

* オートセーブ切り換え
 * 毎ターンにする事で、多少お手軽ゲームになる
 * それもあってファルコン法は不能

* アニメ設定切り換え
 * 敵将戦は強制的にアニメオン
 * 敵or友軍ターン時にAおしっぱの場合、強制アニメオフ
 * アニメオフの状態でもLを押し続けている間はアニメオン 逆も可

* Lループ
 * 敵にカーソルを合わせてLを押すと、敵を順繰りするようにした　友軍も同様

* Lスイッチ
 * 敵杖範囲表示and敵全体の攻撃範囲表示への切り換えボタンをLに変更

* 救出条件変更
 * 騎兵救出不可（ただしスリープ中は可能）
 * バサーク中の味方ユニット救出(+救出中の物交換)が可能
 * 輸送隊にチェックが入っていると救出されなくなる

* 攻速減算値
 * （体格 → 体格+技/4）

* 杖
 * 杖は魔力ではなく、武器レベルで性能向上する仕様

* 武器・杖盗み
 * 力の制限が無い蒼炎・暁式の盗み
 * ただし敵将(+輸送隊にチェックが入った敵)からは盗めない

* 機動力向上
 * アーマーナイト
 * グレートナイト
 * マージナイト
 * トルバドール
 * ヴァルキュリア
 * フォレストナイト
 * マスターロード

* 武器
 * 光魔法は魔物に2倍特効（なおイーヴァルディ3倍）  
 * レイピアの騎馬系特効を修正（タルヴォスとかにも効きます）  
 * 遠距離魔法が軽量弱威力化(イクリプスは相対的に強化)  
 * ルナ > ルイン  
 * リザイアの吸収量半減  
 * エイルカリバー復帰

* アイテムがやたらと交換できる

* 支援
 * 5回まで、ではなく5人までに変更
 * 支援効果は変わらないが、上限がついた
 * A支援は一人としか結べない

* 武器S補正
 * 威力+1・命中+10
 * 攻速落ち無視

* 状態異常弱体化
 * 敵将は状態異常を1ターンで解除
 * 自軍が受ける状態異常杖効果は3ターン

* エフラム編の後半の敵をちょっと変えた

##武器変化
杖は他の武器レベルSと両立が可能です

* 僧侶シスター(+光)
* 魔道士(+光)
* シャーマン(+理)
* サマナー(-杖)
* マージナイト(-杖 +光)
* パラディン(+杖C)
* ファルコンナイト(+杖E +剣D)
* ウォーリア(弓レベルC)
* ローグ(+杖C)

##追加データ
###パッチ系(一部)
* 16 tracks/12 sounds patch
* Native Instrument Map
* Drum Fix(修正版)
* sound_mixer
* コマンド01ハック(未利用)
* コマンド48ハック(未利用)
* FE8 Free Range(未利用)
* 状態異常剣パッチ(未利用)
* FE8変身拡張パッチEA(未利用)
* 3分岐CCパッチ
* Exceed the Portrait Hackbox
* Circles` Spell Animation Engine

###アニメ
* パラディン杖男女
* アサシン弓
* ラガルトアサシン剣弓
* 新ジェネラル斧
* 新バーサーカー
* ファルコンナイト杖
* ドラゴンマスター斧
* ローグ杖
* アーマーナイト剣
* アーマーナイト斧
* ファルコンナイトPaledit
* ドラゴンマスターPaledit
* ワイバーンナイトPaledit
* ローグPaledit

###楽器
* チューバ(FE7)
* マリンバ(FE7)
* オーケストラヒット(FE6)
* エレキギター(FE7)

###MIDI
* 新紋章より「決起のとき」(100)

###魔法
* 入れてない

##スキル
[奥義]は武器レベルSが発動条件  

###個人スキルの付け外し
####効果設定
PFEで幸運成長から右へ4番目の2Bytes

+1|+2|+4|+8
---|---|---|---
大盾|祈り|見切り|練達
キャンセル|怒り|勇将|待ち伏せ
連続|エリート|再行動|すり抜け
回復|王の器|カリスマ|恐怖

####奥義設定
会話グループの右隣の項目   
(個人奥義をつけるユニットは、奥義を持たない兵種にしかなれなくするのが懸命です　複数奥義を持っている場合の処理を雑に作ってある為)

1|2|3|4
---|---|---|---
流星|月光|太陽|天空

####アイコン設定
"Engine Hacks\Skills\UNIT.bin"を編集する

###スキル効果
* 回避+15（ソードマスター）

* 回避-20（騎兵）
 * 屋内の騎乗兵は回避マイナス

* 瞬殺（127ダメージ > ダメージ5倍）
 * 瞬殺ボーナス無し
 * 直接攻撃でのみ発動

* 天空
 * 必殺と重複しない
 * 間接攻撃では発動しない
 * 手斧系では発動しない
 * HP吸収武器では発動しない

* 流星
 * 剣のみ アサシンでは発動しない
 * 間接攻撃では発動しない
 * 必殺発生率ゼロでは発動しない
 * 0.5～7.5倍のダメージ

* 怒り
 * 闘技場では発動しない
 * ホプロンの守護で無効化できない
 
* キャンセル
 * 闘技場では発動しない

* カリスマ
 * 支援効果扱い
 * よって支援効果上限に引っかかる

* 待ち伏せ
 * 相手の待ち伏せを無効化

* 連続
 * 勇者武器を装備すると発動しない

* 必的
 * 発動で大盾・祈り・神盾を無効化

* 見切り
 * 確率スキル・怒り・待ち伏せ・練達を無効化
 * 両者が所持していた場合、両者ともスキル無効
 * 神盾の効果を軽減

* 勇将
 * 条件を満たすとスキル発動率+30
 * 上昇した発動率は見切りで無効化されない

##空き領域マッピング

```
5BA470～(元アイテムアイコン)  
自作魔法リスト～5BB85C

A9DDDC～(元サウンドルーム)  
ちょっと使ってる

E47180～  
NativeInstrumentMap  
その他諸々　EA指定のメイン使用領域

EFB2E0～  
（空き）
```

