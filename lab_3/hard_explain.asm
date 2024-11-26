section .text
global main
main:
    mov rbp, rsp; for correct debugging
    sub rsp, 100         
    push rbp             
    mov rbp, rsp         
    
      
    ;mov ecx, 10         
;    
;    mov [rbp + 16],      
;    lea  rcx, [rbp+16]
    mov rcx, -1
    mov eax, ecx
    mov qword[rsp + 8], 1
    lea rdx, [rsp + 8] 
    

    movzx eax, byte[rdx]
    
    mov dword[rbp-4], 0
    
    xor     r10d, r10d
    xor     r8d, r8d
    
    mov     r9d, r8d
    xor     eax, r10d
    and     r9d, 3
    mov     [rbp+r9-4], al ;r9 = 0
    lea     eax, [r8+1] ;r8 = 0
    mov     r8, rax
    movzx   eax, byte[rdx+rax]
    
    mov  eax, [rbp-4]
    
    mov eax, dword[rcx]
    cmp [rcx], eax
    jz qq
    
 
    pop rbp             
    add rsp, 100         
    xor rax, rax    
qq:
    ret                  
