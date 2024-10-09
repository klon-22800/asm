%include "io64.inc"
section .rodata:
    x: dd 1.1
section .bss
result: resd 1
section .text
global main

main:
    mov rbp, rsp; 
    
    fld dword[x] ; положили на стэк икс
    sub rsp,8 ;выделили 8 бит на стэке
    fstcw [rsp] ;сохранили управляющее слово на стэк
    mov al, [rsp+1] ; взяли из слова второй байти, где лежит RC
    and al, 0xF3 ;Маска для изменения 11110011 - 2-й и 3-й бит управляют RC 
    or al, 11 ; 11[1011] - округление вверх, 12[1100] - окргуление к нулю, 19[10011] -к ближайшему целому,  23[10111] - округление вниз
    mov [rsp+1], al ;Загрузили измененное слово обратно в регистр
    fldcw [rsp]    ; обновили новое слово
    add rsp, 8 ;почистили стэк 
    fist dword[result] ;округлили в result
    
    mov eax, [result]
    PRINT_DEC 4, eax
    xor eax, eax
    ret