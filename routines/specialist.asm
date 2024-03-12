; Очищает весь экран Специалиста заданным в A цветом
cls:
  LD DE,$0000
  CP c00  ; Чёрный
  JP Z,cls_3
  DEC DE
cls_3:
  LD (color_port),A
  LD HL,$0000
  ADD HL,SP
  LD (cls_1+$01),HL
  LD SP,$C000
  LD BC,$0018
cls_2:
  PUSH DE
  DEC B
  JP NZ,cls_2
  DEC C
  JP NZ,cls_2
cls_1:
  LD SP,$0000
  RET

cheat:
	ld a,(live_dec)
	cp $b7	; Код команды OR A
	ret z

	; Проверка одновременного нажатия клавиш ZX PK RU
	ld a,$82	
	ld (kb_port_3),a	; Переключаем ВВ55 на чтение рядов
	ld a,(kb_port_1)	
	
	and %00111000		; Проверка рядов c нужными буквами
	ret nz

	ld a,#91
	ld (kb_port_3),a	; Переключаем ВВ55 на чтение столбцов

	ld a,%11011111			; Без этого дополнения не срабатывают 
	ld (kb_port_1),a
	
	ld a,(kb_port_2)
	and %00001111
	cp %00001100			; Проверяем нажатие кнопки U и K
	ret nz
	ld a,(kb_port_0)
	cp %11111011		; Проверяем нажатие кнопки Z
	ret nz

	ld a,%11101111			; Без этого дополнения не срабатывают 
	ld (kb_port_1),a
	
	ld a,(kb_port_0)
	cp %00111111		; Проверяем нажатие кнопки P и R
	ret nz

	ld a,%11110111			; Без этого дополнения не срабатывают 
	ld (kb_port_1),a
	
	ld a,(kb_port_0)
	cp %11011111		; Проверяем нажатие кнопки X
	ret nz

	call border_flash
	
	ld a,$b7	; Код команды OR A
	ld (live_dec),a
	
	ret

border_flash:
	ld b,5
border_flash_02:
	push bc
border_flash_01:
	ld a,$ff
	cpl
	ld (border_flash_01+$01),a
	call border
	
	; ld d,20
	; call pause_short
	
	pop bc
	dec b
	jp nz,border_flash_02
	ret

border:
	ld (border_01+$01),a
	ld (border_02+$01),a
	ld (border_03+$01),a
	ld (border_04+$01),a
	
	ld hl,$9000
	ld bc,$0008
border_01:
	ld a,$ff
	call bord
	
	ld hl,$9800
	ld bc,$2020
border_02:
	ld a,$ff
	call bord	
	
	ld hl,$98e0
	ld bc,$2020
border_03:
	ld a,$ff
	call bord	
	
	ld hl,$b800
	ld bc,$0008
border_04:
	ld a,$ff
	call bord
	ret



; hl - адрес
; c - ширина
; b - высота
; a - цвет
bord:
	ld (bord_06+$01),a
	ld a,b
	ld (bord_04+$01),a
	ld (bord_05+$01),a

	ld a,c42
	ld (color_port),a

bord_04:	
	ld b,$00	; Высота
bord_06:	
	ld a,$ff
bord_03:	
	ld (hl),a
	inc l
	dec b
	jp nz,bord_03
	ld a,l
bord_05:
	sub $00		 ; Высота
	ld l,a
	inc h
	dec c
	jp nz,bord_04
	ret
