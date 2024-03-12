rem .\tools\sjasmplus --i8080 batty.asm
.\tools\sjasmplus batty.asm
python .\tools\bin2rks.py batty.bin
.\tools\Emu80qt\Emu80qt.exe batty.rks -sz
