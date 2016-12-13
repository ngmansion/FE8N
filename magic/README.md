#魔力分離パッチ

##ユニット設定
![demo](http://i.imgur.com/PM3TYoD.png)  
この部分です。
![demo](http://i.imgur.com/E5ZowzC.png)


##クラス設定
![demo](http://i.imgur.com/BhJxLsC.png)  
この部分です。

![demo](http://i.imgur.com/7VtiQGq.png)  
左から順に、「CCボーナス」「成長率」「初期値」となっております。  
バーサーカー等の一部クラスはこの部分が最初から設定されていますが、未だに何に利用されているか分からない没データの可能性が高い欄なので使います。

##ドーピング
![demo](http://i.imgur.com/2tNlSSm.png)  
ボディリングを使うと増やせます。説明等は変えた方がいいと思います。  
体格の値を変えると魔力を増やせます。

##攻速
攻速計算を変えている人は要注意ですこのパッチを当てるとデフォルトの計算式に戻ります。
 * Atk_Spd.asm
 * Atk_Spd.gba
自分の攻速計算式が使いたい人は、asmを編集・gbaに変換してください。ASM知識必須。
