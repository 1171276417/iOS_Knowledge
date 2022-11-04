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
    
//    char text[] = "AABACDFABABC";
//    char target[] = "ACDFA";
//
//    bool ishave = kmpSearch(text, target);
//
//    NSLog(@"");
    
    char a[] = "萨法啊萨法啊水电费打发发嘎是个撒撒地方爱上发";
    char b[] = "打发发嘎";
    
    __unused bool ishave = kmpSearch(a, b);

  
    NSLog(@"");

}


/// KMP查找函数
bool kmpSearch(char text[], char target[]) {
    
    /**文本原始长度*/
    int N = getStringCount(text);
    /**目标字符串原始长度*/
    int M = getStringCount(target);
    
    /**目标字符串标准化数组*/
    StringArr *targetArr = initStringArray(target, M);
    /**文本字符串标准化数组*/
    StringArr *textArr = initStringArray(text, N);

    /**初始化并构建DFA**/
    int **DFA = initDFA_kmp(targetArr);

    /**DFA中是否能匹配文本**/
    bool ishave = search(textArr, targetArr, DFA);
    
    return ishave;
}

///将字符串标准化返回StringArr*
StringArr* initStringArray(char target[], int initialLength) {
    
    //创建并初始化StringArr
    StringArr *arr = (StringArr *)malloc(sizeof(StringArr));
    arr->setSize = 0;
    arr->length = 0;
    arr->charArr = (char **)malloc(sizeof(char*)*arr->length);
    for(int k = 0; k < arr->length; k++)
        arr->stringArr[k] = (char *)malloc(sizeof(char)*3);
    arr->charCount = 0;
    arr->stringArr = NULL;
    
    /**ASCII字符个数*/
    int ASCIICount = 0;
    /**Unicode字符个数*/
    int UnicodeCount = 0;
    
    //计算字符串真实长度
    for(int i = 0; i < initialLength; i++) {
        if((int)target[i] < 0)  UnicodeCount++;     //Unicode编码占三个char，并且int强转为负
        if((int)target[i] > 0)  ASCIICount++;       //ASCII字符占一个char，int转换为正
    }
    arr->length = ASCIICount + UnicodeCount/3;      //字符串真实长度
    
    //开辟二维char数组存字符串
    arr->stringArr = (char **)malloc(sizeof(char*)*arr->length);
    for(int k = 0; k < arr->length; k++)                          //数组长度为length
        arr->stringArr[k] = (char *)malloc(sizeof(char)*3);         //数组每个元素为一个长为3的字符串
    
    //初始化数组元素
    for(int n = 0; n < arr->length; n++)
        for(int m = 0; m < 3; m++)
            arr->stringArr[n][m] = '\0';
    
    /**原始字符串位置下标*/
    int location = 0;
    //将原始字符串标准化存入数组中
    for(int i = 0; i < arr->length; i++) {
        if((int)target[location] > 0) {
            arr->stringArr[i][0] = target[location];
            location++;     //ASCII字符占一个char,所以location+1
        }
        else {
            arr->stringArr[i][0] = target[location++];
            arr->stringArr[i][1] = target[location++];
            arr->stringArr[i][2] = target[location++];  //Unicode编码占3个char,所以location+3
        }
    }
    
    //计算获得数组元素集合
    arr->charSet = (char **)malloc(sizeof(char*)*arr->length);
    for(int i = 0; i < arr->length; i++) {
        if(getLocationInArray(arr, arr->stringArr[i]) == -1) {
            arr->charSet[arr->setSize] = arr->stringArr[i];     //如果集合中不存在，则存入新元素
            arr->setSize++;
        }
    }
    
    return arr;
}

///初始化并构建kmp的DFA
int** initDFA_kmp(StringArr *arr) {
    //开辟DFA二维数组
    int **DFA = (int**)malloc(sizeof(int*)*arr->length);
    for(int i = 0; i < arr->length; i++)
        DFA[i] = (int *)malloc(sizeof(int)*arr->setSize);
    
    //初始化DFA
    for(int i = 0; i < arr->length; i++)
        for(int j = 0; j < arr->setSize; j++)
            DFA[i][j] = '\0';
    
    //构建DFA
    DFA[0][getLocationInArray(arr, arr->stringArr[0])] = 1;
    for(int X = 0, j = 1; j < arr->length; j++) {
        for(int k = 0; k < arr->setSize; k++)
            DFA[j][k] = DFA[X][k];
        DFA[j][getLocationInArray(arr, arr->stringArr[j])] = j+1;
        X = DFA[X][getLocationInArray(arr, arr->stringArr[j])];
    }
    
    return DFA;
}

///DFA中是否能匹配文本
bool search(StringArr *textArr, StringArr *targetArr, int **DFA) {
    /**文本位置*/
    int i;
    /**目标字符串位置*/
    int j;
    for(i = 0, j = 0; i < textArr->length && j < targetArr->length; i++) {
        /**该文本字符在目标字符串集合的位置*/
        int location = getLocationInArray(targetArr, textArr->stringArr[i]);
        if(location == -1)
            j = 0;
        else
            j = DFA[j][location];
    }
    if(j == targetArr->length)
        return YES;    //找到匹配
    else
        return NO;   //到达文本末尾未找到匹配
}

///获得该字符在集合的位置
int getLocationInArray(StringArr *arr, char *data) {
    for(int i = 0; i < arr->setSize; i++) {
        if(arr->charSet[i][0] == data[0] && arr->charSet[i][1] == data[1] && arr->charSet[i][2] == data[2])
            return i;
    }
    return -1;
}





@end
