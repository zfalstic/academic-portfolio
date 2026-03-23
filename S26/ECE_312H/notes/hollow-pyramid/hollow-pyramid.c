#include <stdio.h>

int main() {
    int n = 3;
    for(int i = 1; i <= n; i++) {
        // Print leading whitespaces
        for(int j = 1; j <= n - i; j++) {
            printf(" ");
        }

        if(i == 1) {
            printf("A");
        } else if(i == n) {
            for(int j = 0; j < n * 2 - 1; j++) {
                printf("%c", 'A' + j);
            }
        } else {
            printf("A");
            for(int j = 0; j < (i - 2) * 2 + 1; j++) {
                printf(" ");
            }
            printf("%c", 'A' + (i - 1) * 2);
        }
        printf("\n");
    }
}
