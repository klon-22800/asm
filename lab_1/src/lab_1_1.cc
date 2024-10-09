#include <stdio.h>


int main() {
    unsigned int n, i, j, minIdx;
    int temp;
    int arr[100];

    printf_s("¬ведите количество элементов массива: ");
    scanf_s("%d", &n);




    printf_s("¬ведите элементы массива:\n");
    for (i = 0; i < n; i++) {
        scanf_s("%d", &arr[i]);
    }


    for (i = 0; i < n - 1; i++) {
        minIdx = i;

        for (j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIdx]) {
                minIdx = j;
            }
        }

        if (minIdx != i) {
            temp = arr[i];
            arr[i] = arr[minIdx];
            arr[minIdx] = temp;
        }
    }

    printf_s("ќтсортированный массив: \n");
    for (i = 0; i < n; i++) {
        printf_s("%d ", arr[i]);
    }

    return 0;
}