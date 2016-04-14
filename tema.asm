org 100h   
INCLUDE 'emu8086.inc'
right_pos db 0


;setari mod video
mov ah, 0h
mov al, 03h
int 10h
ret
jmp menu

move MACRO
    mov al, right_pos
    add al, 1
    mov right_pos,al
    mov al, 0
    mov ah, 6h
    mov bh, 17 ;albastru
    mov ch, 0
    mov cl, 0
    mov dh, 25
    mov dl, 80
    int 10h

    mov ch, right_pos  ;colt stanga sus
    mov cl, right_pos
    mov dh, right_pos  ;dimensiunile patratului
    mov dl, right_pos
    push cx
    push dx
    mov bh, 54 ;alb
    int 10h
    mov ah, 02
    mov dl, 07h ;valoare care produce beep
    int 21h ;produce sunet

    jmp choose
ENDM

draw MACRO w,a,s,d

    mov al, 0
    mov ah, 6h
    mov bh, 64 ;rosu
    mov ch, 0
    mov cl, 0
    mov dh, 25
    mov dl, 80
    int 10h

    mov ch, w
    mov cl, a
    mov dh, s
    mov dl, d
    push cx
    push dx
    mov bh, 87 ;mov
    int 10h
ENDM


moveSquare:
    move

animate:
    draw 0,0,10,12
    draw 1,0,11,12
    draw 2,0,12,12
    draw 3,0,13,12
    draw 4,0,14,12
    draw 5,0,15,12
    draw 6,0,16,12
    draw 7,0,17,12
    draw 8,0,18,12
    draw 9,0,19,12
    draw 10,0,20,12
    draw 11,0,21,12
    draw 12,0,22,12
    draw 13,0,23,12
    draw 14,0,24,12
    draw 15,0,25,12
    draw 14,0,24,12
    draw 13,0,23,12
    draw 12,0,22,12
    draw 11,0,21,12
    draw 10,0,20,12
    draw 9,0,19,12
    draw 8,0,18,12
    draw 7,0,17,12
    draw 6,0,16,12
    draw 5,0,15,12
    jmp menu



choose:      ;taste optiunea 1
    
    mov ah, 1
    mov bh, 32
    int 21h
    cmp al, 'd'
    je diagonal
    cmp al, 'b'
    je menu

menu:
    mov dh, 0
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h 
    mov al, 0
    mov ah, 6h
    mov bh, 2 ;rosu
    mov ch, 0
    mov cl, 0
    mov dh, 25
    mov dl, 80
    int 10h
    PRINTN '1-miscare!'
    PRINTN '2-asteapta click!'
    PRINTN '3-animatie!'

    mov ah, 1
    mov bh, 32
    int 21h
    cmp al, '1'
    je moveSquare
    cmp al, '2'
    je waitClick
    cmp al, '3'
    je animate

waitClick:
    mov al, 0
    mov ah, 6h
    mov bh, 2 ;rosu
    mov ch, 0
    mov cl, 0
    mov dh, 25
    mov dl, 80
    int 10h
    PRINTN 'click pentru menu!'
    jmp mouse

mouse:      ;la click se intoarce in meniu 
    
    mov ax,03h
    int 33h      ;get mouse button info
    cmp bl, 1
    je menu
    jmp mouse

diagonal:  ;Deplasare spre dreapta
    move  
    
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
ret

      
      


