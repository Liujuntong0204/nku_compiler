#include <stdio.h>
#include <time.h>  // 用于计时
#define test "这是一个宏定义～"
clock_t start,stop;
double duration;

int main() {
    start = clock();

    printf("%s\n", test);
    
    int a, b, i, t, n;
    // 常量折叠，观察优化
    a = 0 + 1 - 1;
    b = 1;
    i = 1;
    // 一个从未被使用的变量，观察优化
    int c = 2000;

    // 使用scanf来读取用户输入
    scanf("%d", &n);
    // 使用printf输出ab两个斐波那契数
    printf("%d\n", a);
    printf("%d\n", b);

    // 输出后续的斐波那契数
    while (i < n) {
        t = b;
        b = a + b;
        printf("%d\n", b);
        a = t;
        i = i + 1;
    }

    // 一段死代码，观察优化
    if(0==1){ printf("%s\n", "这不对吧？");}


    stop = clock();
    duration = (double)(stop - start) / CLOCKS_PER_SEC;
    printf("程序运行时间为：");
    printf("%f\n", duration);

    return 0;
}
