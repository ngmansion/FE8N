@echo off
chcp 65001
cd /d %~dp0

set /p number="ファイル数を入力してください："


  type nul > list_definitions.event
  echo #define COMBAT_ART_LIST_SIZE (8)>> list_definitions.event
  echo ALIGN 4 >> list_definitions.event
  echo combat_art_table:>> list_definitions.event
  echo BYTE 0 0 0 0 0 0 0 0 >> list_definitions.event

  type nul > combat_index.event

setlocal enabledelayedexpansion
for /l %%n in (1,1,%number%) do (
  set counta=%%n
  set num=00%%n
  set num=!num:~-3,3!
  type nul > skill_!num!.txt

  echo #define COMBAT_ART_!num!_ATK 00 >> skill_!num!.txt

  echo #define COMBAT_ART_!num!_HIT 00 >> skill_!num!.txt

  echo #define COMBAT_ART_!num!_CRT 00 >> skill_!num!.txt

  echo #define COMBAT_ART_!num!_AVO 00 >> skill_!num!.txt

  echo #define COMBAT_ART_!num!_COST 05 >> skill_!num!.txt

  echo #define COMBAT_ART_!num!_WEAPON $FF >> skill_!num!.txt

  echo #define COMBAT_ART_!num!_INFO 00 >> skill_!num!.txt

  echo #define COMBAT_ART_!num!_DUMMY 00 >> skill_!num!.txt

  echo BYTE COMBAT_ART_!num!_ATK COMBAT_ART_!num!_HIT COMBAT_ART_!num!_CRT COMBAT_ART_!num!_AVO COMBAT_ART_!num!_COST COMBAT_ART_!num!_WEAPON COMBAT_ART_!num!_INFO COMBAT_ART_!num!_DUMMY >> list_definitions.event

  echo #include skill_!num!.txt >> combat_index.event
)
endlocal

  echo WORD $FFFFFFFF $FFFFFFFF >> list_definitions.event
  echo #include list_definitions.event >> combat_index.event
  pause
  exit

)

