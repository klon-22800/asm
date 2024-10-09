%include "io64.inc"
section .bss
    array resq 1000 

section .text
global main

;n-rax
;i-rbx
;j-rcx (во время сортировки)
;minI - rdx
; tmp - rsi
main:
    mov rbp, rsp              
    GET_DEC 8, rax             ; Получаем количество элементов N
    mov rbx, 0                  ; Счетчик для цикла (типа i - index)
    
    
input_loop:
    GET_DEC 8, rcx              ;введеное число
    mov [array+rbx*8], rcx        ;записываем в массив
    PRINT_DEC 8, [array+rbx*8]
    PRINT_STRING ' '                ;вывод через пробел
    add rbx, 1                      ; увеличиваем i+=1
    cmp rax, rbx                    ; i<n
    jg input_loop
    
start_sorting:
    mov rbx, 0                    ;начальный индекс внешнего цикла i
    
outer_loop:
    cmp rbx, rax-1  ;if (i >= n - 1) goto print_array;
    jge print_array
    mov rdx, rbx    ;minIdx = i;
    mov rcx, rbx    ;j=i
    add rcx, 1      ;j++
    
inner_loop:
    cmp rcx, rax ;if (j >= n) goto swap_elements;
    jge swap_elements
    mov rdi, [array+rcx*8] ;arr[j]]
    cmp [array+rdx*8],rdi  ;if (arr[minIdx] > arr[j]) goto inner_help;
    jg inner_help
    add rcx, 1 ; j++
    jmp inner_loop ;goto inner_loop
   
inner_help:
    mov rdx, rcx    ;minIdx = j
    add rcx, 1      ;j++
    jmp inner_loop  ;goto inner_loop
    
swap_elements:
    cmp rdx, rbx    ;if (minIdx != i) goto start_swap;
    jne start_swap
    add rbx, 1      ;i++
    jmp outer_loop  ;goto outer_loop
  
start_swap:  

    mov rsi, [array+rbx*8]  ;temp = arr[i]
    mov rdi, [array+rdx*8]
    
    mov [array+rbx*8], rdi    ;arr[i] = arr[minIdx]
    mov [array+rdx*8], rsi      ;arr[minIdx] = temp
    
    add rbx, 1      ;i++
    jmp outer_loop      ;goto outer_loop

    
print_array:
    mov rbx, 0
    PRINT_STRING '->'  
    
output_loop:
    cmp rbx, rax
    jge end
    PRINT_DEC 8, [array+rbx*8]
    PRINT_STRING ' '                
    add rbx, 1
    cmp rax, rbx
    jg output_loop

end:
    ret
 
      