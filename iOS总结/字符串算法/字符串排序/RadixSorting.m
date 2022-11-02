//
//  RadixSorting.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/24.
//

#import "RadixSorting.h"

@implementation RadixSorting

- (void)RadixSortingAlgorithm {
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"456", @"644", @"236", @"986", @"486", @"486" ,@"593", @"694", @"992", @"167", nil];
    
    int data[] = {980, 435, 532, 5888, 134, 24, 643, 90, 363};
    radixSort(data);
    
}

///算法实现
void radixSort(int data[]) {
    int n = -1;    //数组长度n
    while (data[n] != '\0') {
        n++;
    }
    n = 9;
    int digit = maxbit(data, n);    //位数
    int count[10];    //计数器
    int *tmp = malloc(n*sizeof(int));
    int i,j,k;
    int radix = 1;
    
    for(i = 1; i <= digit ;i++) {   //进行digit次排序
        for(j = 0; j < 10; j++) {
            count[j] = 0;   //每次排序时清空计数器
        }
        for(j = 0; j < n; j++) {
            k = (data[j]/radix)%10;
            count[k]++;
        }
        for(j = n-1; j >= 0; j--) {
            k = (data[j]/radix)%10;
            tmp[count[k] - 1] = data[j];
            count[k]--;
        }
        for(j = 0; j < n; j++) {//将临时数组的内容复制到data中
            data[j] = tmp[j];
        }
        radix = radix * 10;
    }
    
    printf("%d, %d, %d, %d, %d, %d, %d, %d, %d",data[0],data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8]);
    
    NSLog(@"");

    free(tmp);
    
}





///获得最大值的位
int maxbit(int data[], int n) {
    int maxdata = data[0];
    //取得最大值
    for(int i = 0; i < n; i++) {
        if(maxdata < data[i]) {
            maxdata = data[i];
        }
    }
    
    //取最大值的位数
    int a = 1;
    int b = 10;
    
    while (maxdata >= b) {
        maxdata /= 10;
        ++a;
    }
    return a;
}






@end
