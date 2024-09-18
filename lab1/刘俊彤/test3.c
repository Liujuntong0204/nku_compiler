#include <stdio.h>  

// 浮点数 if分支判断 输入输出

int main() {  
    float num1, num2;  
  
    // 提示用户输入两个浮点数  
    printf("请输入第一个浮点数: ");  
    scanf("%f", &num1);  
    printf("请输入第二个浮点数: ");  
    scanf("%f", &num2);  
  
    // 使用if判断语句比较两个数  
    if (num1 > num2) {  
        // 如果第一个数大于第二个数，则打印以下信息  
        printf("%.2f 大于 %.2f\n", num1, num2);  
    } else {  
        // 如果第一个数不大于第二个数（即小于或等于），则打印以下信息  
        printf("%.2f 不大于 %.2f\n", num1, num2);  
    }  
  
    return 0;  
}