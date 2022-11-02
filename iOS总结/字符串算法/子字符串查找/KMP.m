//
//  KMP.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/27.
//

#import "KMP.h"
#import "Boyer-Moore.h"

@implementation KMP

///KMP算法
void kmp(void) {
    
    char text[] = "AABACDFABABC";
    char target[] = "AABACDFABABC";
    
    bool ishave = kmpSearch(text, target);
    
    NSString *a;
    if( [a containsString:@"a"]) {
        
    }
    
    NSLog(@"");
    
    //char a[] = "哈喽";
    //printf("%d, %d",(int)a[0],(int)a[1]);
    
    
}


/// KMP查找函数
/// - Parameters:
///   - text: 文本字符串
///   - target: 目标字符串
bool kmpSearch(char text[], char target[]) {
    int N = getStringCount(text);   //文本长度
    int M = getStringCount(target);     //目标字符串长度
    int (*dfa)[128] = (int(*)[128])malloc(sizeof(int)*128*M);
    
    constructDFA(target, dfa, M);
    
    return search(text, target, N, M, dfa);
}


/// 构造DFA
void constructDFA(char target[], int (*dfa)[128], int M) {
    dfa[0][(int)target[0]] = 1;
    for(int X=0, j=1; j<M; j++) {
        for(int k=0; k<128; k++)
            dfa[j][k] = dfa[X][k];  //复制匹配失败的值
        dfa[j][(int)target[j]] = j+1;   //设置匹配成功的值
        X = dfa[X][target[j]];  //更新重启状态
    }
}


/// search在text中模拟DFA
bool search(char text[], char target[], int N, int M, int (*dfa)[128]) {
    int i;  //文本位置
    int j;  //目标字符串位置
    for(i = 0, j = 0; i < N && j < M; i++)
        j = dfa[j][(int)text[i]];
    if(j == M)  return true;    //找到匹配
    else    return false;   //到达文本末尾未找到匹配
}


int encodeChar(char a, char encoderChar[]) {
    int i = 0;
    while (encoderChar[i]) {
        if(encoderChar[i] == a)
            return i;
        i++;
    }
    encoderChar[i] = a;
    return i;
}






@end
