%include "io64.inc"
section .data

section .text
    extern access2         
    global main            


     ; xmm1 = xmm0
     ; xmm0 = rdx+4
     ; xmm0 = xmm0* rdx+8
     ; xmm3 = rdx
     ; xmm1 += xmm0
     ; xmm0 = 3.0
     ; xmm0 = xmm0 * rdx+12
     ; xmm0 += xmm3
     ; xmm0 = xmm0 - 1.0
     ; if xmm1< xmm0 go to  1
     
     
     ;1:
     ;xmm0 = -1.0
     ; if xmm0 > xmm2 cl =1
     
     
main:
    mov rbp, rsp; for correct debugging
    
    mov rax, 0       ; Загружаем число 42 в регистр eax
    PRINT_DEC 8, rax
    mov [rdx + 4], rax ; Записываем это число по адресу rdx + 4

    sub rsp, 40            
    
    call access2     


    add rsp, 40


    ret
