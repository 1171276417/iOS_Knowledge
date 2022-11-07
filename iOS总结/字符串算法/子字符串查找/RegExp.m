//
//  RegExp.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/30.
//

#import "RegExp.h"
#import "Boyer-Moore.h"
#import "KMP.h"
#import "DataStructure.h"



@implementation RegExp

#pragma mark - 正则表达实现
///主函数
void regularExpression(void) {
    
//    char text[] = "ABD";
//    char target[] = "((A*B|AC)D)";
    
    char text[] = "我我我我BD";
    char target[] = "((我*B|AC)D)";

    __unused bool ishave = regExp(text, target);
    
    
    NSLog(@"");
}

/// 正则表达式判断实现
bool regExp(char text[], char target[]) {
    /**文本原始长度*/
    int N = getStringCount(text);
    /**正则式原始长度*/
    int M = getStringCount(target);
    
    /**目标字符串标准化数组*/
    StringArr *targetArr = initStringArray(target, M);
    /**文本字符串标准化数组*/
    StringArr *textArr = initStringArray(text, N);
    
    Digraph *digraphNFA = createNFA(targetArr);
    
    /**创建一个图结构,用于表示NFA的ε转换*/
    DFAStruct *DFA = createDFA(targetArr, digraphNFA);
    
    int i;  //文本位置
    int j;  //目标字符串位置
    for(i = 0, j = 0; i < textArr->length && j < targetArr->length; i++) {
        if(getLocationInArray(targetArr, textArr->stringArr[i]) == -1)
            j = 0;
        else
            j = DFA->dfa[j][getLocationInArray(targetArr, textArr->stringArr[i])];
        if(belongArray(DFA->terminationState, j))
            return YES;
    }
    return NO;
}

/// 构建NFA用于判断 ε 转换
Digraph* createNFA(StringArr *targetArr) {
    Digraph *digraph = initGraph(targetArr);
    
    LinkStack stack = initStack();
    
    for(int i = 0; i < targetArr->setSize; i++) {
        targetArr->charSet[i] = NULL;
    }
    targetArr->setSize = 0;
    
    for(int i = 0; i < targetArr->length; i++) {
        if(*targetArr->stringArr[i] != '(' && *targetArr->stringArr[i] != ')' && *targetArr->stringArr[i] != '|' && *targetArr->stringArr[i] != '*') {
            targetArr->charArr[targetArr->charCount] = targetArr->stringArr[i];
            targetArr->charCount++;
         
            if(getLocationInArray(targetArr, targetArr->stringArr[i]) == -1) {
                targetArr->charSet[targetArr->setSize] = targetArr->stringArr[i];
                targetArr->setSize++;
            }
        }
        
        int lp = i;
        if(*targetArr->stringArr[i] == '(' || *targetArr->stringArr[i] == '|') {
            pushStack(i, stack);
        }
        else if(*targetArr->stringArr[i] == ')') {
            int or = popStack(stack);
            if(*targetArr->stringArr[or] == '|') {
                lp = popStack(stack);
                linkGraphNode(digraph, lp, or+1);
                linkGraphNode(digraph, or, i);
            }
            else lp = or;
        }
        if (i < targetArr->length-1 && *targetArr->stringArr[i+1] == '*') {
            linkGraphNode(digraph, lp, i+1);
            linkGraphNode(digraph, i+1, lp);
        }
        if(*targetArr->stringArr[i] == '(' || *targetArr->stringArr[i] == '*' || *targetArr->stringArr[i] == ')') {
            linkGraphNode(digraph, i, i+1);
        }
    }
    return digraph;
}


///将NFA转换为DFA
DFAStruct* createDFA(StringArr *targetArr, Digraph *digraphNFA) {
    
    //将ε转换图的集合
    Set **epsilonSet = (Set **)malloc(sizeof(Set *)*targetArr->length);
    for(int i = 0; i < targetArr->length; i++) {
        epsilonSet[i] = epsilonChange(digraphNFA, i, targetArr->length);
    }
        
    //DFA
    DFAStruct *DFA = initDFA();
    
    Queue *stateQueue = initQueue();
    enQueue(stateQueue, epsilonSet[0]);
    
    //DFA状态的集合
    DFAStateSet *stateSet = initStateSet();

    while (!queueEmpty(stateQueue)) {
        Set *set = deQueue(stateQueue);
        addStateSet(stateSet, set);
        for(int i = 0; i < targetArr->setSize; i++) {
            Set *set0 = matchcConversion(set, *targetArr->charSet[i], epsilonSet, digraphNFA);
            if(stateSame(stateSet, set0)) {
                DFA->dfa[stateSame(stateSet, set)-1][getLocationInArray(targetArr, targetArr->charSet[i])] = stateSame(stateSet, set0)-1;
            }
            else{
                enQueue(stateQueue, set0);
                DFA->dfa[stateSame(stateSet, set)-1][getLocationInArray(targetArr, targetArr->charSet[i])] = stateSet->count;
                addStateSet(stateSet, set0);
            }
            
            if(isRepetition(set0, targetArr->length)) {
                addArray(DFA->terminationState, stateSame(stateSet, set0)-1);
            }
        }
    }
    return DFA;
}


///顶点 i 经过epsilon转换到达的顶点集合
Set* epsilonChange(Digraph *digraph, int i, int M) {
    Set *set = initSet();
    insert(set, i);
    graphPreOrderTraverse(NULL, digraph, digraph[i].firstedge, set, M);
    return set;
}


///图的深度优先遍历
void graphPreOrderTraverse(EdgeNode *EnodeLast, Digraph *digraph, EdgeNode *Enode, Set *set, int M) {
    if(EnodeLast) {
        if(Enode == NULL)
            Enode = EnodeLast->next;
        if(EnodeLast->adjvex == M)
            return;
    }
    while (Enode == NULL || (isRepetition(set, Enode->adjvex) && Enode->next)) {
        if(Enode && Enode->next)
            Enode = Enode->next;
        if(Enode == NULL || (isRepetition(set, Enode->adjvex) && !Enode->next))
            return;
    }
    do {
        insert(set, Enode->adjvex);
        graphPreOrderTraverse(Enode, digraph, digraph[Enode->adjvex].firstedge, set, M);
        Enode = Enode->next;
    }while(Enode);
}


///匹配转换
Set* matchcConversion(Set *oldSet, char matchChar, Set **NFA, Digraph *digraph) {
    
    Set *newSet = initSet();
    
    Array *arr = initArray();
    treePreorderTraversal(oldSet->rootNode, arr);
    
    int k = 0;
    while (digraph[arr->array[k]].data != matchChar) {
        k++;
        if(k == arr->count)
            return NFA[0];
    }
    
    for(int i = 0; i < arr->count; i++) {
        if(digraph[arr->array[i]].data == matchChar)
            newSet = set_union(NFA[arr->array[i]+1], newSet);
    }
    return newSet;
}







@end
