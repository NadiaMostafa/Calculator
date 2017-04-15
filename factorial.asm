
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
   mov ah, 00h
   int 16h
   mov ah, 0Eh
   int 16
   sub al, '0'
   mov dl, al
   mov bl, 1
   cmp dl, 1
   je l1
   while:mul bl
   inc bl
   cmp bl, dl
   jne while
   jmp ex
   l1:mov ax, 1 
   ex:
    mov cx, 0 
    mov bx, 10
    storedigit:mov dx, 0 
    idiv bx 
    add dx, '0'
    push dx
    inc cx
    cmp ax, 0
    jne storedigit
    printdigit:pop dx
    push ax
    mov al, dl
    mov ah, 0Eh
    int 16
    pop ax
    dec cx
    cmp cx, 0
    jne printdigit
    

ret




