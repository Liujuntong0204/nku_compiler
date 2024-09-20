#include <stdio.h>  

// 数组 除法 for循环 打印

int main() {  
    // 定义一个整型数组，包含5个元素  
    int numbers[] = {1, 2, 3, 4, 5};  
      
    // 数组的大小  
    int size = 5;  
      
    // 遍历数组并打印每个元素  
    for(int i = 0; i < size; i++) {  
        printf("%d ", numbers[i]);  
    }  
      
    return 0;  
}