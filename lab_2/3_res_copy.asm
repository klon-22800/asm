%include "io64.inc"

section .rodata
    a: dd 5.0
    b: dd -1.0         ;-1 <= b <= 1     
    e: dd 2.71828               
    
section .text
global main
arccos:
    
main:
    mov rbp, rsp; for correct debugging
    ; изначально cos(ln(x + a)) = b    -> Решение-> x = e^arccos(b)-a
    ; так как арккосинуса нет то переписываем через арктан arccos(x) = 2*arctan(sqrt( (1-x)/(1+x)) )
    ; итого:  x = e^2*arctan(sqrt( (1-b)/(1+b)) ) -a
    ;ПОЛИЗ e 2 arctan sqrt 1 b - 1 b + / * ^ a -
    mov rbp, rsp; for correct debugging
    ; Вычисляем 1 - b
    fld dword [b]                    ; Загружаем b
    fld1                             ; Загружаем 1.0 в стек 
    fsub st0, st1                   ; 1 - b, теперь в st0
    
    ;  Вычисляем 1 + b

    fld1                             ; Загружаем 1.0 в стек FPU
    faddp st2, st0                   ; 1 + b, теперь в st1
    fld st1                          ; еще раз закидываем 1+b наверх, для будущего деления

    
    ; Делим (1 - b) / (1 + b)
    fdivp st1, st0                   ; st0 = (1 - b) / (1 + b)= st1/st0
    fstp st1                          ; тут осталась сумма, ее выкидываем
    
    ;  Вычисляем sqrt((1 - b) / (1 + b))
    fsqrt                             ; st0 = sqrt(st0)
    
    
    ;  Вычисляем atan(sqrt((1 - b) / (1 + b)))
    fld1
    fpatan                           ; st1 = atan(st1 / st0)

    
    ; Умножаем результат на 2
    fadd st0, st0                    ; 2 * atan
    
    ; e^sto
    fld dword[e]
    fyl2x ;вычисляем показатель
    fld1 ;загружаем +1.0 в стек
    fld st1 ;дублируем показатель в стек
    fprem ;получаем дробную часть
    f2xm1 ;возводим в дробную часть показателя
    fadd ;прибавляем 1 из стека
    fscale ;возводим в целую часть и умножаем
    fstp st1 ; выталкиваем лишнее из стека
    
    ; -a
    fld dword[a]
    fsubr st0, st1
    fstp st1
    fstp st0
            
    ret
