%include "io64.inc"

section .rodata
    a: dd 1.0
    x: dd 1.0  ;учитывать что sin(x) + a > 0 
    
    y: dd 100.1         
               
section .text
global main
arccos:
    
main:
    mov rbp, rsp; for correct debugging
    ; изначально y < ln^3(sinx +a)
     ; ln(X) = log2(x) * ln(2) ->  log2(x) - fyl2x 

    ;ПОЛИЗ ln 3 sin x a + ^
    mov rbp, rsp; for correct debugging
    
    ;sin(x)
    fld dword[x] ; st0 =x
    fsin           ; st0 = sin(st0)
    
    ;st0 + a
    fld dword[a]    
    fadd            ; st0 = st0 + st1
    
    ;ln(st0) = log2(st0) * ln(2)
    ; fyl2x: st1 = st1 * log2(st0) поэтому грузим единичку
    fld1
    fld st1
    fyl2x 
    fstp st1
    fldln2
    fmul st1
    fstp st1
    
    ; st0^3 = st0*st0 * st0
    fst st1
    fmul st0, st0
    fmul st0, st1
    fstp st1
    
    ; сравнение
    fld dword[y]
    fcomip 
    jnb false
    PRINT_DEC 4, 1
    jmp end

false:
    PRINT_DEC 4, 0
          
end:       
    ret