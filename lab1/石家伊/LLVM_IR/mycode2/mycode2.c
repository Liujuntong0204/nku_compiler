#include <stdio.h>  
  
// 函数调用 输入输出


// 定义一个函数，该函数接收两个整数作为参数，并返回它们的和  
int addNumbers(int a, int b) {  
    return a + b; // 返回两个数的和  
}  
  
int main() {  
    int num1; // 定义第一个整数  
    int num2; // 定义第二个整数  
    scanf("%d %d", &num1, &num2);
      
    // 调用addNumbers函数，并将结果存储在变量sum中  
    int sum = addNumbers(num1, num2);  
      
    // 打印结果  
    printf("The sum of %d and %d is %d\n", num1, num2, sum);  
      
    return 0; // 程序正常结束  
}