%include "io64.inc"

section .rodata
    x: dd 5.0              ; Значение x для вычисления e^x 
    one: dd 1.0
    c1: dd 1.0             ; ДА НАЧНЕТСЯ ФАКТОРИАЛ КАКАЯ ЖЕ НАМ ВСЕМ 


section .bss
    result: resd 1         ; Переменная для хранения результата
section .text
global main
;xmm0 - сюда пишу сумму
;xmm1 - сюда пишу икс, потом домножаю на икс
;xmm2 - сюда пишу 1, потом делаю факториал
;xmm3 - сюда записываю дробь
;xmm4 - текущее n для факториала
;eax  - метка выхода, когда ноль ливаю с цикла

main:
    mov rbp, rsp; for correct debugging
    
    ;Первая дробь вне цикла
    mov rax, 35 ; точность лучше задавать в два раза больше чем x
    
    movss xmm0, dword[c1] ;sum
    movss xmm4, dword[c1] ;n
    
    movss xmm1, dword[x] ; x
    movss xmm2, dword[c1] ; n!

    
    movss xmm3, xmm1 ;записал числитель
    divss xmm3, xmm2  ;поделил на знаменатель
    
    addss xmm0, xmm3    ;Прибавил к сумме
    
    addss xmm4, dword[c1]  ; 
    
    
cycle:
    cmp rax, 0
    je end
    
    mulss xmm1, dword[x]
    mulss xmm2, xmm4
    
    movss xmm3, xmm1
    divss xmm3, xmm2
    
    addss xmm0, xmm3
    
    addss xmm4, dword[c1]
    
    add rax, -1
    jmp cycle
    
  
end:

    xor eax, eax           ; Завершаем программу
    ret