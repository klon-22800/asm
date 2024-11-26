%include "io64.inc"

section .rodata
    test: dq -2.0
    
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
    
    mov eax, 15       ; Загружаем число 42 в регистр eax
    mov [rdx + 4], eax ; Записываем это число по адресу rdx + 4
    mov eax, 1      ; Загружаем число 42 в регистр eax
    mov [rdx + 8], eax ; Записываем это число по адресу rdx + 4
    
    
    mov eax, 1       
    mov [rdx], eax 
    mov eax, 1       
    mov [rdx + 12], eax 
    
    
    movsd xmm2, qword[test]
    
    sub rsp, 40            
    
    call access2     


    add rsp, 40


    ret
