section .text
    extern access1        
    global main            
main:
    mov rbp, rsp

    sub rsp, 100 
    
    mov qword[rsp + 8], 1
    lea rdx, [rsp + 8] 
    
    mov ecx, 1
    

    call access1 

    add rsp, 100

    ret
