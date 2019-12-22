@echo off
chcp 65001
cd /d %~dp0

set /p number="ファイル数を入力してください："


  type nul > list_definitions.event
  echo #define ICON_LIST_SIZE (20)>> list_definitions.event
  echo skl_table:>> list_definitions.event
  echo SHORT 0 0 >> list_definitions.event
  echo POIN 0 0 0 0 >> list_definitions.event

  type nul > config_index.event

setlocal enabledelayedexpansion
for /l %%n in (1,1,%number%) do (
  set counta=%%n
  set num=00%%n
  set num=!num:~-3,3!
  type nul > skill_!num!.txt

  echo skill_!num!_unit:>> skill_!num!.txt
  echo    BYTE $00 $00 0 >> skill_!num!.txt

  echo skill_!num!_class:>> skill_!num!.txt
  echo    BYTE $00 $00 0 >> skill_!num!.txt

  echo skill_!num!_weapon:>> skill_!num!.txt
  echo    BYTE $00 $00 0 >> skill_!num!.txt

  echo skill_!num!_item:>> skill_!num!.txt
  echo    BYTE $00 $00 0 >> skill_!num!.txt


set DATA=$0000
call :MYSET2 !counta! 1
  echo #define SKL_HELP_!num! !DATA!>> skill_!num!.txt

set DATA=$00
call :MYSET2 !counta! 2
  echo #define SKL_COLOR_!num! !DATA!>> skill_!num!.txt

  echo SHORT SKL_HELP_!num! SKL_COLOR_!num! >> list_definitions.event
  echo POIN skill_!num!_unit skill_!num!_class skill_!num!_weapon skill_!num!_item>> list_definitions.event

  echo #include skill_!num!.txt >> config_index.event
)
endlocal

  echo WORD $FFFFFFFF $FFFFFFFF $FFFFFFFF $FFFFFFFF $FFFFFFFF>> list_definitions.event
  echo ALIGN 4 >> config_index.event
  pause
  exit

:MYSET2
FOR /F "tokens=%2 skip=%1" %%i IN (config_icon.txt) DO (
    SET DATA=%%i
    exit /b
)

