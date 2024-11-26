section .rodata
    test_1: dd 15.0
section .text
    extern access1  
    global main
main:
    mov rbp, rsp; for correct debugging
    sub rsp, 40            
    
    mov dword[rsp + 8], 53414249h     
    lea  rcx, [rsp+8]
    
    mov byte[rcx+4], 0h
    cmp byte[rcx+4], 0
    
    mov dword[rcx+8], 00000000h
    
    mov dl, 10

    movsd xmm2, [test_1]
    
    call access1     

qq:
    
    add rsp, 40
    xor rax, rax
    ret