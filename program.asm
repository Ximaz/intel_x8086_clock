    BITS 16

    section .bss
    digits resb 2

    section .text
    global _start

_start:
    xor ax, ax
    mov byte [digits], 0
    mov byte [digits + 1], 0

    call display_time

    call display_crlf

    mov ah, 4ch
    int 21h

display_time:
    push bp
    mov bp, sp

    mov ah, 2Ch
    int 21h

    mov al, ch
    call display_digits
    
    mov ah, 02h
    mov dl, ':'
    int 21h

    mov al, cl
    call display_digits
    
    mov ah, 02h
    mov dl, ':'
    int 21h

    mov al, dh
    call display_digits

    leave
    ret

display_digits:
    push bp
    mov bp, sp

    call extract_digits
    
    add byte [digits], 30h
    add byte [digits + 1], 30h

    mov ah, 02h
    mov dl, [digits]  ; Reads the tens of hour
    int 21h
    mov dl, [digits + 1] ; Reads the units of hour
    int 21h

    leave
    ret

extract_digits:
    push bp
    mov bp, sp

    xor ah, ah

    push bx
    mov bl, 10
    div bl
    pop bx

    mov byte [digits], al
    mov byte [digits + 1], ah

    leave
    ret

display_crlf:
    push bp
    mov bp, sp

    mov ah, 02h
    mov dl, 13  ; '\r'
    int 21h
    mov ah, 02h
    mov dl, 10  ; '\n'
    int 21h

    leave
    ret