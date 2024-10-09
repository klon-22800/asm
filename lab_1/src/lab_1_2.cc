#include <stdio.h>



int main() {
    unsigned int n, i = 0, j, minIdx;
    int temp, arr[100];

    scanf_s("%d", &n);

input_loop:
    if (i >= n) goto start_sorting;  
    scanf_s("%d", &arr[i]);
    i++;
    goto input_loop;  

start_sorting:
    i = 0;  

outer_loop:
    if (i >= n - 1) goto print_array;  
    minIdx = i;
    j = i;
    j++;

inner_loop:
    if (j >= n) goto swap_elements; 
    if (arr[minIdx] > arr[j]) goto inner_help;
    j++;
    goto inner_loop; 

inner_help:
    minIdx = j;
    j++;
    goto inner_loop;

swap_elements:
    if (minIdx != i) goto start_swap;

    i++;
    goto outer_loop;  

start_swap:
    temp = arr[i];
    arr[i] = arr[minIdx];
    arr[minIdx] = temp;
    i++;
    goto outer_loop;


print_array:
    i = 0; 

output_loop:
    if (i >= n) goto end_program;  
    printf_s("%d ", arr[i]);
    i++;
    goto output_loop; 

end_program:
    return 0;
}