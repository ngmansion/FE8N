@echo off
chcp 65001
cd /d %~dp0

set /p number="ファイル数を入力してください："




setlocal enabledelayedexpansion
for /l %%n in (1,1,%number%) do (
  set counta=%%n
  set num=00%%n
  set num=!num:~-3,3!
  

  
  copy /b one\skill_!num!.txt + two\skill_!num!.txt skill_!num!.txt
  echo; >> set\skill_!num!.txt
  
)
endlocal

  pause
  exit

