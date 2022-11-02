//
//  Boyer-Moore.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/26.
//

#import "Boyer-Moore.h"


@implementation Boyer_Moore

void boyerMoore(void) {
    
    char text[] = "ASIMPLE EXAMPLE";
    char target[] = "EXAMPLE";
    
    char a[] = "跳出内层循环；外层循环依然执行，直到 i>4 成立，跳出外层循环。内层循环共执行了4次，外层循环共执行了1次";
    char b[] = "额";
    
    
    bool ishave = boyerMooreSearch(a, b);
    
    NSLog(@"");
}


///查找文本中是否有目标字符串
bool boyerMooreSearch(char text[], char target[]) {
    int N = getStringCount(text);  //文本长度
    int M = getStringCount(target);  //目标字符串长度
    int location = 0;   //目标字符串位置偏移量
    int match = 0;  //匹配量，成功匹配字符数
    int i = M-1+location;  //文本位置,从右开始对比
    int j = M-1;  //目标字符串位置，从右开始对比
    
    do {
        for(i=i,j=j; i>i-M && j>j-M; i--,j--) {
            if(text[i] == target[j]) {
                match++;    //该位置匹配成功，匹配数加1
                if(match == M) return true;
            }
            else {
                if(match) {
                    location += maxNumber(badChar(text[i], target, j), goodSuffix(target[M-1], target, M));    // 匹配数不为0，既有好后缀又有坏字符,选择最大的偏移量移动字符串
                }
                else {
                    location += badChar(text[i], target, j);    //匹配数为0，没有好后缀，只有坏字符
                }
                if(i+match == N-1) {
                    return false;
                }
                break;  //匹配到了坏字符，结束本次循环
            }
        }
        i = M-1+location;
        j = M-1;
        match = 0;
        if(i >= N) {
            return false;
        }
    }while(match < M);
    
    return true;
}


///获得字符串长度
int getStringCount(char string[]) {
    int count = 0;
    while (string[count]) {
        count++;
    }
    return count;
}

///坏字符规则
int badChar(char badChar, char target[], int i) {
    int j = i-1;
    while (badChar != target[j]) {
        j--;
        if(j < 0) break;
    }
    return i-j;
}


///好后缀原则
int goodSuffix(char lastChar, char target[], int count) {
    int j = count-2;
    while (lastChar != target[j]) {
        j--;
        if(j < 0) break;
    }
    return count-1-j;
}

///比较返回最大数
int maxNumber(int a, int b) {
    if(a > b) {
        return a;
    }
    else
        return b;
}




@end
