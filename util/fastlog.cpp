#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
typedef unsigned long uint32;
typedef long int32;
const int N = 10000000;
float list[N];
int32 fast_log(float x){ //32位浮点数
	uint32 ix = *(uint32*)&x; // 先取x在内存中的地址，再以int32的方式将浮点数取出
	uint32 exp = (ix >> 23) & 0xFF; // 去掉右边的尾数部分
	int32 log2 = int32(exp) - 127; // 指数部分存储的是指数+127
	return log2;
}
int32 normal_log(float x){
	return int32(log2(x));
}
int main(){
	clock_t start, end, duration;
	float x;
	srand(time(NULL));
	for (int i = 0; i < N; i++){
		list[i] = rand()/float(RAND_MAX); // 生成0-1之间的随机数
        //printf ("list[%d]=%f\n",i,list[i]);
    }
	int32 log2x;
	//printf("Please input number:");
	//scanf("%f", &x);
    // 优化后的方法
    start = clock();
    for (int i = 0; i < N; i++){
	    log2x = fast_log(list[i]);
    }
    end = clock();
    printf ("duration = %lf (before optimization)\n",double(end-start));
    // 优化前的方法
    start = clock();
    for (int i = 0; i < N; i++){
	    log2x = log2(list[i]);
    }
    end = clock();
    printf ("duration = %lf (after optimization)\n",double(end-start));
	//printf("int log2(x) = %ld\n", log2x);
}