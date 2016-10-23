FE8Nとは、改造FEのベースとする為に作った改造FEです

# 修正メモ

##ステータス
HPの上限は、クラスHP上限を参照します
ただし敵将はクラスHP上限が80未満でも80まで引き上げられます

敵のステータスは上限突破させています
味方はさせていません

##改変点

成長率とかAIとか、聞いた事がある分は海外版準拠に
(全ユニット守備成長率+10という独善的アレンジもしてあります

##システム

###オートセーブ切り換え
毎ターンにする事で、多少お手軽ゲームになります。
なお、それもあってファルコン法は不能にしてあります。

###救出条件変更
騎兵救出不可（ただしスリープ中は可能）
バサーク中の味方ユニット救出可能

###攻速減算値
（体格 → 体格+技/4）

###杖
杖は魔力ではなく、武器レベルで性能向上する仕様

###武器・杖盗み
力の制限が無い蒼炎・暁式の盗みです
ただし敵将からは盗めません

###機動力向上
アーマーナイト・グレートナイト・マージナイト・トルバドール・ヴァルキュリア・フォレストナイト・マスターロード

###武器
光魔法は魔物に2倍特効（なおイーヴァルディ）
レイピアの騎馬系特効を修正（タルヴォスとかにも効きます）
遠距離魔法が軽量弱威力化(イクリプスは相対的に完全強化)
ルナ > ルイン
リザイアの吸収量半減
エイルカリバー復帰
レギンレイヴの特効剥奪

###アイテムがやたらと交換できる

###支援
A一人だけ、それ以外なら6人と結べます

###S補正
命中+10

###Y?ダッシュ
カーソルの移動がセレクトを押すことでも速くなります

###Ｌでアニメ切り換え
アニメオフの状態でもLを押し続けている間はアニメオンになります
逆も可


###エフラム編の後半の敵をちょっと変えた

##武器変化
杖は他の武器レベルSと両立が可能です

###僧侶
（+光）
###魔道士
（+光）
###シャーマン
（+理）
###サマナー
(-杖)
###マージナイト
(-杖 +光)
###パラディン
(+杖C)
###ファルコンナイト
(+杖E +剣D)
###ウォーリア
(弓レベルC)
###ローグ
(+杖C)

##追加データ
###パッチ系(一部)
* コマンド01ハック
* コマンド48ハック
* まほーぱっち
* 太陽パッチ
* sound_mixer
* Native instrument 
* DrumFix

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

###MIDI
* 新紋章より「決起のとき」(100)

###魔法
* 無い

##スキル
[奥義]は武器レベルSが発動条件

###回避+15（ソードマスター）

###瞬殺（127ダメージ > ダメージ5倍）
（瞬殺ボーナス無し）
（直接攻撃でのみ発動）

###天空
必殺と重複しない
間接攻撃武器では不発

###流星
ソドマス専用
間接攻撃武器では不発
0.5～7.5倍の攻撃

###見切り
神盾の効果を軽減

##使用空き領域マッピング

5BA470～
マップアイコン

EF2F18～
midiデータ

E47180～
逆汗

EFB330
アイテム・スキルアイコン

F04330
NativeInstrumentMap
あと色々

