.MODEL SMALL 
.DATA
    operators db 150 dup (?)
    operands db 150 dup (?)
    temp db 0
    char db ?
    cnt dw 0 
    ten db 10  
    ;msg0 db "result",0Dh,0Ah
.CODE
.STARTUP
    mov si, 0 
    lea bx, operators
    lea bp, operands    
    while:mov ah,00h
    int 16h 
    mov ah, 0Eh
    int 16
    mov char,al
    cmp char, '='
    je exit
    cmp char, '+'
    je l1
    cmp char, '-'
    je l1
    cmp char, '*'
    je l1
    cmp char, '/' 
    je l1  
    mov al, temp 
    mov ah, 0 
    mov dh,10
    imul dh
    mov temp, al
    sub char,'0'
    mov al, char
    add temp,al 
    l2:jmp while 
    l1:mov al, char
    mov bx[si], al 
    mov al, temp
    mov bp[si], al
    inc si   
    mov temp, 0  
    jmp l2
    exit:mov al, temp
    mov bp[si], al
    mov cx, si
    ;inc cx
    mov si, 0
    mov al, bp[si]
    mov ah, 0
    push ax 
    inc cnt
    lable:mov al, bx[si]
    inc si
    cmp al, '*'
    je multiply
    cmp al, '/'
    je divide 
    cmp al, '-'
    je minus
    mov al, bp[si]
    mov ah, 0
    push ax
    inc cnt  
    ;dec cx
    ex:dec cx
    cmp cx, 0
    jne lable 
    mov cx, cnt
    mov dx, 0
    for:pop ax
    add dx, ax 
    dec cx
    cmp cx, 0
    jne for
    jmp print
    multiply:pop ax
    imul bp[si] 
    push ax    
    jmp ex
    divide:pop ax  
    cmp ax, 0
    jns resetdx
    mov dx, 0FFFFh
    l3:push bx
    mov bl, bp[si]
    mov bh, 0
    idiv bx
    pop bx
    push ax
    jmp ex
    minus:mov al, bp[si]      
    mov dl, -1
    imul dl
    mov ah, 0FFh
    push ax
    inc cnt 
    jmp ex   
    print:cmp dx, 0
    je printzero
    jns positive
    mov char, '-' 
    push AX
    mov al, char
    mov ah, 0Eh
    int 10h     
    pop ax
    not dx
    add dx,1
    positive:
    mov cx, 0
    mov ax, dx 
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
    printzero:mov char, '0'
    push ax
    mov al, char
    mov al, 0Eh
    int 16     
    pop ax
    jmp close 
    resetdx:mov dx, 0  
    jmp l3
    close:  
    .EXIT
    END 