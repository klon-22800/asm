%include "io64.inc"
EXTERN scanf, printf, malloc, free   ; Подключаем внешние функции C

section .data
    fmt_in db "%d", 0                   ; Формат для scanf
    fmt_out db "%d ", 0                 ; Формат для printf
    fmt_arrow db "-> ", 0               ; Стрелка для вывода отсортированного массива

section .bss
    array resq 1                        ; Указатель на динамически выделенный массив

section .text
global main

;n-rax
;i-rbx
;j-rcx (во время сортировки)
;minI - rdx
; tmp - rsi
main:
    mov rbp, rsp              
    sub rsp, 16                     ; Резервируем место для локальных переменных
    
    ; Получаем количество элементов N
    mov rdi, fmt_in                 ; Задаем формат ввода для scanf
    mov rsi, rsp                    ; Указываем адрес для хранения N
    call scanf                      ; scanf("%d", &N)
    mov rax, [rsp]                  ; Загружаем N в rax
    
    ; Выделение памяти для массива через malloc
    mov rdi, rax                    ; Количество элементов массива
    shl rdi, 3                      ; Умножаем на размер int64 (8 байт) -> rdi = N * 8
    call malloc                     ; Вызов malloc(N * 8)
    mov [array], rax                ; Сохраняем указатель на массив в array
    mov rbx, 0                      ; Счетчик для цикла (i - index)
    
input_loop:
    mov rdi, fmt_in                 ; Адрес строки формата для scanf
    mov rsi, rsp                    ; Адрес, куда будет сохранено число
    call scanf                      ; Считываем число и сохраняем его по адресу в rsi
    mov rcx, [rsp]                  ; Загружаем считанное значение в rcx
    mov rax, [array]                ; Загружаем указатель на массив
    mov [rax + rbx*8], rcx          ; Записываем число в массив
    mov rdi, fmt_out                ; Формат для вывода
    mov rsi, [rax + rbx*8]          ; Значение для вывода
    call printf                     ; Печать значения через printf
    add rbx, 1                      ; Увеличиваем i+=1
    cmp rbx, [rsp]                  ; Сравниваем i с N
    jl input_loop                   ; Если i < N, продолжаем ввод
    
start_sorting:
    mov rbx, 0                      ; Начальный индекс внешнего цикла i

outer_loop:
    cmp rbx, [rsp]                  ; if (i >= n - 1) goto print_array
    jge print_array
    mov rdx, rbx                    ; minIdx = i
    mov rcx, rbx                    ; j = i
    add rcx, 1                      ; j++
    
inner_loop:
    cmp rcx, [rsp]                  ; if (j >= n) goto swap_elements
    jge swap_elements
    mov rax, [array]                ; Указатель на array
    mov rdi, [rax + rcx*8]          ; arr[j]
    cmp [rax + rdx*8], rdi          ; if (arr[minIdx] > arr[j]) goto inner_help
    jg inner_help
    add rcx, 1                      ; j++
    jmp inner_loop                  ; Переход к inner_loop
   
inner_help:
    mov rdx, rcx                    ; minIdx = j
    add rcx, 1                      ; j++
    jmp inner_loop                  ; Переход к inner_loop
    
swap_elements:
    cmp rdx, rbx                    ; if (minIdx != i) goto start_swap
    jne start_swap
    add rbx, 1                      ; i++
    jmp outer_loop                  ; Переход к outer_loop
  
start_swap:  
    mov rax, [array]                ; Указатель на array
    mov rsi, [rax + rbx*8]          ; temp = arr[i]
    mov rdi, [rax + rdx*8]          ; arr[minIdx]
    
    mov [rax + rbx*8], rdi          ; arr[i] = arr[minIdx]
    mov [rax + rdx*8], rsi          ; arr[minIdx] = temp
    
    add rbx, 1                      ; i++
    jmp outer_loop                  ; Переход к outer_loop

    
print_array:
    mov rdi, fmt_arrow              ; Печатаем стрелку перед отсортированным массивом
    call printf
    
    mov rbx, 0
output_loop:
    cmp rbx, [rsp]
    jge cleanup
    mov rax, [array]                ; Указатель на array
    mov rdi, fmt_out                ; Формат для вывода
    mov rsi, [rax + rbx*8]          ; Значение для вывода
    call printf                     ; Печать значения через printf
    add rbx, 1
    jmp output_loop

cleanup:
    mov rax, [array]                ; Загружаем указатель массива
    call free                       ; Освобождаем память
    add rsp, 16                     ; Восстанавливаем стек
    ret
