; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

data segment
    
    febonacciArr db 1000 dup (?)
     char db ?
     temp db 0
     
    
    code segment
    while:mov ah,00h
    int 16h 
    mov ah, 0Eh
    int 16
    mov char,al
    cmp char,'f'
    je febonacci
    mov al, temp 
    mov ah, 0 
    mov dh,10
    mul dh
    mov temp, al
    sub char,'0'
    mov al, char
    add temp,al  
      jmp while
       
   febonacci:
   lea bp, febonacciArr 
   mov cl,temp 
   mov si,0  
   mov ax,0 
   mov al ,1
   mov bp[si],al                            
   inc si
   mov bp[si],al
   dec cl  
   cmp temp, 2
   jbe exit
 l2:  
    mov ax, bp[si-1] 
    add ax,bp[si] 
    inc si  
    mov bp[si],ax
    mov bx ,si
    cmp bl ,cl
    jne l2
    en:
    mov ah, 0
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
    jmp close 
    exit:
    mov al, bp[si]
    mov ah, 0
    jmp en
     close:
     