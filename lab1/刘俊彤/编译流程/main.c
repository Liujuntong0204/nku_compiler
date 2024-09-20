#include <stdio.h>  
#include <time.h>
#define x 1234

clock_t start, stop;
double duration;

int main() {  
    start = clock();
    int i, n, f;  
    printf("请输入一个整数n: ");  
    scanf("%d", &n); // 从标准输入读取n的值  
    
    if(0)
    {
        printf("死代码部分");
    }


    i = 12-2*5;  //测试常量折叠
    f = 1; // 阶乘的初始值为1（因为0! = 1! = 1）  
    //开始循环
    while (i <= n) {  
        f = f * i; // 计算阶乘  
        i = i + 1; // 递增i  
    }  
  
    printf("%d的阶乘是: %d\n", n, f); // 输出结果  
    printf("宏定义验证：%d\n", x); //验证宏定义

    stop = clock();
    duration = (double)(stop - start) / CLOCKS_PER_SEC;
    printf("程序运行时间为：");
    printf("%f\n", duration);
  
    return 0;  
}