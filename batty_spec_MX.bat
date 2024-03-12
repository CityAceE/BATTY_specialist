rem .\tools\sjasmplus --i8080 batty_spec.asm
.\tools\sjasmplus -DMX batty.asm
fc /B batty.i80 .\tools\batty_for_compare.i80
rem python .\tools\bin2rks.py batty.i80
pause
