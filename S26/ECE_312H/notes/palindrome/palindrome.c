#include <stdio.h>
#include <string.h>

int main() {
    char str[50];
    char reverse[50] = {0};
    scanf("%s", str);
    int length = strlen(str);
    for(int i = 0, j = length - 1; i < length; i++, j--) {
        reverse[i] = str[j];
    }
    //printf("%s\n", str);
    //printf("%s\n", reverse);
    if(strcmp(str, reverse) == 0) {
        printf("%s is a palindrome", str);
    } else {
        printf("%s is not a palindrome", str);
    }
}
