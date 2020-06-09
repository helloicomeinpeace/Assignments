.MODEL LARGE 
.STACK 100h
obj STRUC
	original_x dw ?
        original_y dw ?
	current_x dw ?
	current_y dw ?
        direction dw ?
obj ENDS
BulletObj STRUC
        x dw ?
        y dw ?
        active dw 0
BulletObj ends
DrawPixel MACRO x,y,color
        push es
        push ax 
        push cx 
        push bx 
        push dx
        mov ax,320
        mov cx,y;y position
        mul cx
        add ax,x; x position
        mov bx,ax
        mov ax,@FARDATA
        mov es,ax
        mov dl,color
        mov es:[bx],dl
        pop dx 
        pop bx 
        pop cx 
        pop ax
        pop es
ENDM

CheckCollision MACRO x,y
        push es
        push ax 
        push cx 
        push bx 
        push dx
        
        mov ax,[ROBOTobject.original_x]
        cmp ax,x
        ja checkcanoncollision
        add ax,21
        cmp ax,x
        jb checkcanoncollision
        mov ax,[ROBOTobject.original_y]
        cmp ax,y
        ja checkcanoncollision
        mov  dl, 15   ;Column
        mov  dh, 12   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        LEA DX,robothit  
        MOV AH,09H 
        INT 21H 
        mov dx,0
        mov [bx+4],dx;deactivate bullet after collision
        jmp nocollision
        checkcanoncollision:
        mov ax,[CANONA.original_x]
        cmp ax,x
        ja checkcanonBcollision
        add ax,10
        cmp ax,x
        jb checkcanonBcollision
        mov ax,[CANONA.original_y]
        add ax,10
        cmp ax,y
        jb checkcanonBcollision
        mov  dl, 15   ;Column
        mov  dh, 12   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        LEA DX,canonahit 
        MOV AH,09H 
        INT 21H 
        mov dx,0
        mov [bx+4],dx;deactivate bullet after collision
        jmp nocollision
        checkcanonBcollision:
        mov ax,[CANONB.original_x]
        cmp ax,x
        ja nocollision
        add ax,10
        cmp ax,x
        jb nocollision
        mov ax,[CANONB.original_y]
        add ax,10
        cmp ax,y
        jb nocollision
        mov  dl, 15   ;Column
        mov  dh, 12   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        LEA DX,canonbhit 
        MOV AH,09H 
        INT 21H 
        mov dx,0
        mov [bx+4],dx;deactivate bullet after collision
        nocollision:

        pop dx 
        pop bx 
        pop cx 
        pop ax
        pop es
ENDM

.FARDATA?
.FARDATA
.DATA  

;The string to be printed  
seconds db ?         ;◄■■ IMPORTANT VARIABLES IN DATA SEGMENT.
buf     db 6 dup (?)

ROBOTobject obj <160,150,160,150,0>
CANONA obj <200,10,200,10,1>
CANONB obj <120,10,120,10,2>
robothearts obj <250,10,250,10,2>
canonobj dw ?
Bullets BulletObj 10 dup (<>)
CanonABullets BulletObj 10 dup (<>)
CanonBBullets BulletObj 10 dup (<>)
Scoreboard obj <150,5,150,5>
robothit   db  "ROBOT HIT",'$'
canonahit   db  "CANON A HIT",'$'
canonbhit   db  "CANON B HIT",'$'
robothealth dw 5    
color db 181
STRING DB 'This is a sample string', '$'
ROBOT     DB 0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,0,4,4,4,0,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,0,4,4,4,0,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,0,4,4,4,0,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,4,4,4,4,4,15,4,4,4,4,4,0,0,0,0,0,'$'
	  DB 0,0,0,4,4,0,0,4,4,4,4,4,0,0,4,4,0,0,0,0,0,'$'
	  DB 0,0,0,4,4,0,0,0,4,4,4,4,4,0,0,0,4,4,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,0,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,0,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,0,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,0,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,0,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,0,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,4,4,0,4,4,0,0,0,0,0,0,0,0,'$'
	  DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'E'

CANON   DB 14,14,14,14,14,14,14,14,14,14,14,'$'
        DB 14,14,14,14,14,14,14,14,14,14,14,'$'
        DB 14,14,14,14,14,'&',14,14,14,14,14,'$'
        DB 14,14,14,14,14,14,14,14,14,14,14,'$'
        DB 14,14,14,14,14,14,14,14,14,14,14,'$'
        DB '&','&','&','&',14,14,14,'&','&','&','&','$'
        DB '&','&','&','&',14,14,14,'&','&','&','&','$'
        DB '&','&','&','&',14,14,14,'&','&','&','&','$'
        DB '&','&','&','&',14,14,14,'&','&','&','&','$'
        DB '&','&','&','&',14,14,14,'&','&','&','&','$'
        DB '&','&','&','&',14,14,14,'&','&','&','&','E'

LifeHeart   DB 00,00,00,00,00,00,00,00,00,00,00,'$'
            DB 00,15,15,00,00,00,15,15,00,00,00,'$'
            DB 00,15,15,15,00,15,15,15,00,00,00,'$'
            DB 00,00,15,15,15,15,15,00,00,00,00,'$'
            DB 00,00,15,15,15,15,15,00,00,00,00,'$'
            DB 00,00,00,15,15,15,00,00,00,00,00,'$'
            DB 00,00,00,15,15,15,00,00,00,00,00,'$'
            DB 00,00,00,00,15,00,00,00,00,00,00,'$'
            DB 00,00,00,00,15,00,00,00,00,00,00,'$'
            DB 00,00,00,00,00,00,00,00,00,00,00,'E'
.CODE  
MAIN PROC  
 MOV AX,@DATA  
 MOV DS,AX  




CALL INIT_SCREEN
;LEA DX,string2  
  
 ;output the string 
 ;loaded in dx  
 ;MOV AH,09H 
 ;INT 21H  
finito:
mov ah,04ch
int 21h
MAIN ENDP  

INIT_SCREEN PROC NEAR
PUBLIC INIT_SCREEN
Mov ax,13h;MCGA 320x200 256 color graphics mode
Int 10h
game_loop:      
call CLEAR_BUFFER
call DRAW_ROBOT
call DISPLAY_SCORE
call DRAW_CANONS
call DRAW_BULLETS
call REFRESH
call MOVE_BULLETS
call LISTEN_MOUSE
call LISTEN_KEY
call MOVE_CANONS 
mov ax,0B000h
mov es,ax
mov dh,'H'
mov dl,20h
mov si,12
mov es:[si],dx
;▼ GET SYSTEM TIME.
  mov  ah, 2ch
  int  21h       ;◄■■ SECONDS RETURN IN DH. 
;▼ TIMER (1 SECOND).  
  cmp  dh, seconds
  je   game_loop  ;◄■■ REPEAT UNTIL 1 SECOND PASSED.
  mov  seconds, dh
  call FIRE_CANONB_BULLET  ;◄■■ CALL PROCEDURE THAT CONVERTS NUMBER TO STRING.
;▼ CONVERT SECONDS TO STRING.  
  xor  ax, ax  ;◄■■ NUMBER TO CONVERT TO STRING.
  mov  al, dh  ;◄■■ SECONDS IN AX.
  mov cl,al
  AND cl,00000001b
  cmp cl,000000001b
  je game_loop
 ; lea  si, buf  ;◄■■ VARIABLE WHERE STRING WILL BE STORED.
  call FIRE_CANONA_BULLET  ;◄■■ CALL PROCEDURE THAT CONVERTS NUMBER TO STRING.
;▼ MOVE CURSOR TO 0,0.
  ;mov  dl, 0  ;◄■■ X.
  ;mov  dh, 0  ;◄■■ Y.
  ;mov  ah, 2
  ;mov  bh, 0
  ;int  10h  
;▼ DISPLAY STRING.
 ; mov  ah, 9
  ;lea  dx, buf
 ; int  21h
  jmp  game_loop

;cmp cx,320
;je exit
;inc cx
;jmp l1

RET
INIT_SCREEN ENDP

DISPLAY_SCORE PROC NEAR
PUBLIC DISPLAY_SCORE
push [robothearts.original_x]
pop [robothearts.current_x]
mov cx, 5
l13_:
push [robothearts.original_y]
pop [robothearts.current_y]
mov si, offset LifeHeart
l12_:
mov al,[si]
cmp al,'$'
je nextrow2_
cmp al,'E'
je exit2_
cmp al,'&'
je nextx_
DrawPixel robothearts.current_x,robothearts.current_y,[si]
nextx_:
inc robothearts.current_x
inc si
jmp l12_

nextrow2_:
push [robothearts.original_x]
pop [robothearts.current_x]
inc robothearts.current_y
inc si
jmp l12_
;cmp cx,320
;je exit
;inc cx
;jmp l1

exit2_:
dec cx
cmp cx,0
ja l13_
push [robothearts.original_y]
pop [robothearts.current_y]
push [robothearts.original_x]
pop [robothearts.current_x]
RET

DISPLAY_SCORE ENDP


MOVE_CANONS PROC NEAR
PUBLIC MOVE_CANONS
call MOVE_CANONA
call MOVE_CANONB
RET
MOVE_CANONS ENDP

MOVE_CANONA PROC NEAR
PUBLIC MOVE_CANONA
mov ax,CANONA.direction
cmp ax,1
je goleft
inc CANONA.original_x
inc CANONA.original_x
inc CANONA.original_x
mov ax,CANONA.original_x
cmp ax,310
jae change_direction
jmp bass
goleft:
dec CANONA.original_x
dec CANONA.original_x
dec CANONA.original_x
mov ax,CANONA.original_x
cmp ax,10
jbe change_direction
bass:
RET
change_direction:
mov ax,CANONA.direction
cmp ax,1
je change_to_right
change_to_left:
mov ax,1
mov CANONA.direction,ax
jmp bass
change_to_right:
mov ax,2
mov CANONA.direction,ax
jmp bass
MOVE_CANONA ENDP

MOVE_CANONB PROC NEAR
PUBLIC MOVE_CANONB
mov ax,CANONB.direction
cmp ax,1
je goleft_
inc CANONB.original_x
inc CANONB.original_x
inc CANONB.original_x
mov ax,CANONB.original_x
cmp ax,310
jae change_direction_
jmp bass_
goleft_:
dec CANONB.original_x
dec CANONB.original_x
dec CANONB.original_x
mov ax,CANONB.original_x
cmp ax,10
jbe change_direction_
bass_:
RET
change_direction_:
mov ax,CANONB.direction
cmp ax,1
je change_to_right_
change_to_left_:
mov ax,1
mov CANONB.direction,ax
jmp bass
change_to_right_:
mov ax,2
mov CANONB.direction,ax
jmp bass
MOVE_CANONB ENDP

LISTEN_KEY PROC NEAR
PUBLIC LISTEN_KEY
mov ah,01
int 16h
jz returnus
mov ah,0
int 16h
cmp al,'a'
je left
cmp al,'d'
je right
cmp ah,01
je escape
cmp ah,0eh
je pausegame
returnus:
RET
pausegame:
mov ah,01
int 16h
jz pausegame
mov ah,0
int 16h
cmp al,'a'
je left
cmp al,'d'
je right
cmp ah,01
je escape
cmp ah,0eh
je returnus
jmp pausegame
escape:
mov ah,04ch
int 21h
left:
dec ROBOTobject.original_x
dec ROBOTobject.original_x
dec ROBOTobject.original_x
dec ROBOTobject.original_x
dec ROBOTobject.original_x
jmp returnus
right:
inc ROBOTobject.original_x
inc ROBOTobject.original_x
inc ROBOTobject.original_x
inc ROBOTobject.original_x
inc ROBOTobject.original_x
jmp returnus
LISTEN_KEY ENDP

LISTEN_MOUSE PROC NEAR
PUBLIC LISTEN_MOUSE
mov ax,0
int 33H
cmp ax,0
je returnis
mov ax,05
int 33h
cmp ax,01
je fyree
returnis:
RET
fyree:
call FIRE_BULLET
jmp returnis
LISTEN_MOUSE ENDP

MOVE_BULLETS PROC NEAR
PUBLIC MOVE_BULLETS
push bx
push cx
mov bx,offset Bullets
mov cx,0
phir_se:
cmp cx,30
je exitt
mov ax,[bx+4]
cmp ax,1
je move
add bx,6
inc cx
jmp phir_se
exitt:
pop cx
pop bx
RET
deactivate:
mov ax,1
mov word ptr [bx+4],0
jmp cont
move:
cmp cx,10
jae move_enemy
dec word ptr [bx+2]
dec word ptr [bx+2]
dec word ptr [bx+2]
mov ax,[bx+2]
cmp ax,10
jbe deactivate
jmp cont
move_enemy:
inc word ptr [bx+2]
inc word ptr [bx+2]
inc word ptr [bx+2]
mov ax,[bx+2]
cmp ax,190
jae deactivate
cont:
CheckCollision [bx],[bx+2]
add bx,6
inc cx
jmp phir_se
MOVE_BULLETS ENDP

DRAW_CANONS PROC NEAR
PUBLIC DRAW_CANONS
call DRAW_CANONA
call DRAW_CANONB
;DRAW_CANON CANONB
ret
DRAW_CANONS ENDP

DRAW_CANONB PROC NEAR
PUBLIC DRAW_CANONB
push [CANONB.original_x]
pop [CANONB.current_x]
mov si, offset CANON
ll12:
mov al,[si]
cmp al,'$'
je nextrow22
cmp al,'E'
je exit22
cmp al,'&'
je nextxx
DrawPixel CANONB.current_x,CANONB.current_y,[si]
nextxx:
inc CANONB.current_x
inc si
jmp ll12

nextrow22:
push [CANONB.original_x]
pop [CANONB.current_x]
inc CANONB.current_y
inc si
jmp ll12
;cmp cx,320
;je exit
;inc cx
;jmp l1

exit22:
push [CANONB.original_x]
pop [CANONB.current_x]
push [CANONB.original_y]
pop [CANONB.current_y]
RET
DRAW_CANONB ENDP

DRAW_CANONA PROC NEAR
PUBLIC DRAW_CANONA
push [CANONA.original_x]
pop [CANONA.current_x]
mov si, offset CANON
l12:
mov al,[si]
cmp al,'$'
je nextrow2
cmp al,'E'
je exit2
cmp al,'&'
je nextx
DrawPixel CANONA.current_x,CANONA.current_y,[si]
nextx:
inc CANONA.current_x
inc si
jmp l12

nextrow2:
push [CANONA.original_x]
pop [CANONA.current_x]
inc CANONA.current_y
inc si
jmp l12
;cmp cx,320
;je exit
;inc cx
;jmp l1

exit2:
push [CANONA.original_x]
pop [CANONA.current_x]
push [CANONA.original_y]
pop [CANONA.current_y]
RET
DRAW_CANONA ENDP

DRAW_BULLETS PROC NEAR
PUBLIC DRAW_BULLETS
push bx
push cx
mov cx,0
mov bx,offset Bullets
check_next:
cmp cx,30
je sabhogaya
mov ax,[bx+4]
cmp ax,1
je draw
add bx,6
inc cx
jmp check_next
sabhogaya:
pop cx
pop bx
RET
draw:
DrawPixel  [bx], [bx+2],15
add bx,6
inc cx
jmp check_next
DRAW_BULLETS ENDP

FIRE_BULLET PROC NEAR
PUBLIC FIRE_BULLET
push dx
push ax
push bx
push cx
mov bx,offset Bullets
mov cx,0
check_next_index:
cmp cx,10
je nowreturn
mov ax,[bx+4]
cmp ax,0
je FIRE
add bx,6
inc cx
jmp check_next_index
nowreturn:
pop cx
pop bx
pop ax
pop dx
RET
FIRE:
push [ROBOTobject.original_x]
pop dx
add dx,10
mov [bx],dx
push [ROBOTobject.original_y]
pop [bx+2]
mov ax,1
mov [bx+4],ax
jmp nowreturn
FIRE_BULLET ENDP

FIRE_CANONA_BULLET PROC NEAR
PUBLIC FIRE_CANONA_BULLET
push dx
push ax
push bx
push cx
mov bx,offset CanonABullets
mov cx,0
check_next_index_:
cmp cx,10
je nowreturn_
mov ax,[bx+4]
cmp ax,0
je FIRE_
add bx,6
inc cx
jmp check_next_index_
nowreturn_:
pop cx
pop bx
pop ax
pop dx
RET
FIRE_:
push [CANONA.original_x]
pop dx
add dx,6
mov [bx],dx
push [CANONA.original_y]
pop dx
add dx,10
mov [bx+2],dx
mov ax,1
mov [bx+4],ax
jmp nowreturn_
FIRE_CANONA_BULLET ENDP

FIRE_CANONB_BULLET PROC NEAR
PUBLIC FIRE_CANONB_BULLET
push dx
push ax
push bx
push cx
mov bx,offset CanonBBullets
mov cx,0
check_next_index__:
cmp cx,10
je nowreturn__
mov ax,[bx+4]
cmp ax,0
je FIRE__
add bx,6
inc cx
jmp check_next_index__
nowreturn__:
pop cx
pop bx
pop ax
pop dx
RET
FIRE__:
push [CANONB.original_x]
pop dx
add dx,6
mov [bx],dx
push [CANONB.original_y]
pop dx
add dx,10
mov [bx+2],dx
mov ax,1
mov [bx+4],ax
jmp nowreturn__
FIRE_CANONB_BULLET ENDP

CLEAR_BUFFER PROC NEAR
PUBLIC CLEAR_BUFFER
mov ax,@FARDATA
mov ds,ax
xor si,si
xor dx,dx
loop4:
cmp si,64000
je getout
mov ds:[si],dx
add si,2
jmp loop4
getout:
mov ax,@DATA
mov ds,ax
RET
CLEAR_BUFFER ENDP

REFRESH PROC NEAR
PUBLIC  REFRESH
push ax
push cx
xor si,si
mov ax,@FARDATA
mov ds,ax
mov ax,0A000h
mov es,ax
loop1:
cmp si,64000
je return
mov ax, ds:[si]
mov cx, es:[si]
cmp ax,cx
jne swap
add si,2
jmp loop1
return:
pop cx
pop ax
mov ax,@DATA
mov ds,ax
RET
swap:
mov es:[si],ax
mov ds:[si],cx
add si,2
jmp loop1
REFRESH ENDP

DRAW_ROBOT PROC NEAR
PUBLIC DRAW_ROBOT
push [ROBOTobject.original_x]
pop [ROBOTobject.current_x]
mov si, offset robot
l1:
mov al,[si]
cmp al,'$'
je nextrow
cmp al,'E'
je exit
DrawPixel ROBOTobject.current_x,ROBOTobject.current_y,[si]
inc ROBOTobject.current_x
inc si
jmp l1

nextrow:
push [ROBOTobject.original_x]
pop [ROBOTobject.current_x]
inc ROBOTobject.current_y
inc si
jmp l1
;cmp cx,320
;je exit
;inc cx
;jmp l1

exit:
push [ROBOTobject.original_x]
pop [ROBOTobject.current_x]
push [ROBOTobject.original_y]
pop [ROBOTobject.current_y]
RET
DRAW_ROBOT ENDP

;------------------------------------------
;CONVERT A NUMBER IN STRING.
;ALGORITHM : EXTRACT DIGITS ONE BY ONE, STORE
;THEM IN STACK, THEN EXTRACT THEM IN REVERSE
;ORDER TO CONSTRUCT STRING (STR).
;PARAMETERS : AX = NUMBER TO CONVERT.
;             SI = POINTING WHERE TO STORE STRING.

number2string proc NEAR
public number2string  
;FILL BUF WITH DOLLARS.
  push si
  call dollars
  pop  si

  mov  bx, 10 ;DIGITS ARE EXTRACTED DIVIDING BY 10.
  mov  cx, 0 ;COUNTER FOR EXTRACTED DIGITS.
cycle1:       
  mov  dx, 0 ;NECESSARY TO DIVIDE BY BX.
  div  bx ;DX:AX / 10 = AX:QUOTIENT DX:REMAINDER.
  push dx ;PRESERVE DIGIT EXTRACTED FOR LATER.
  inc  cx ;INCREASE COUNTER FOR EVERY DIGIT EXTRACTED.
  cmp  ax, 0  ;IF NUMBER IS
  jne  cycle1 ;NOT ZERO, LOOP. 
;NOW RETRIEVE PUSHED DIGITS.
cycle2:  
  pop  dx        
  add  dl, 48 ;CONVERT DIGIT TO CHARACTER.
  mov  [ si ], dl
  inc  si
  loop cycle2  

  ret
number2string endp

;------------------------------------------
;FILLS VARIABLE WITH '$'.
;USED BEFORE CONVERT NUMBERS TO STRING, BECAUSE
;THE STRING WILL BE DISPLAYED.
;PARAMETER : SI = POINTING TO STRING TO FILL.
dollars proc NEAR
public dollars
  mov  cx, 6
six_dollars:      
  mov  bl, '$'
  mov  [ si ], bl
  inc  si
  loop six_dollars

  ret
dollars endp  
END MAIN 