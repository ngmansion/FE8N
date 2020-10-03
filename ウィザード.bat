@echo off
chcp 65001
cd /d %~dp0

echo ============================================================
echo スキル設定ウィザードを開始します 
echo.
echo 指定スキルに対して、以下の設定変更が可能です 
echo ●どのユニット、クラス、武器、アイテムに持たせるスキルとするか 
echo ●ヘルプに何を表示するか 
echo ●スキルアイコンに使用するパレットをどうするか 
echo ============================================================
pause

type ".\Engine Hacks\_N\_Skills\skill_definitions.event"
echo ============================================================
echo 編集したいスキルのIDを入力しエンターしてください 
echo (※1 16進数の場合は0xを付けてください)(※2 0を入力すると終了します) 
echo ============================================================

:RETURN
set input=
set /p input=
set /a input=%input% * 1
if %input%==0 goto eof

  set num=00%input%
  set num=%num:~-3%
  start notepad .\Engine Hacks\_N\_Skills\config\skill_%num%.txt
  goto RETURN

