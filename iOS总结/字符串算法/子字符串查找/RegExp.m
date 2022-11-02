//
//  RegExp.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/30.
//

#import "RegExp.h"
#import "Boyer-Moore.h"

@implementation RegExp

#pragma mark - 图结构声明
///图边节点
typedef struct EdgeNode {
    int adjvex;     /**该边顶点的位置*/
    struct EdgeNode *next;  /**下一条边*/
}EdgeNode;
///图顶结点
typedef struct VertexNode {
    char data;  /**存顶点信息*/
    EdgeNode *firstedge;    /**第一条以该节点为顶点的边*/
    EdgeNode *lastedge;     /**最后一条边节点*/
}VertexNode, Digraph;


#pragma mark - 栈结构声明
///栈结点
typedef struct StackNode {
    int data;
    struct StackNode *next;
}StackNode, *LinkStack;


#pragma mark - 集合结构声明
///二叉树结点
typedef struct TreeNode {
    int data;
    struct TreeNode *leftChild;
    struct TreeNode *rightChild;
}TreeNode;

///二叉树集合
typedef struct Set {
    TreeNode *rootNode;
    int nodeCount;
}Set;

#pragma mark - 数组结构声明
typedef struct Array {
    int *array;
    int length;
    int count;
}Array;

#pragma mark - 队列结构声明
typedef struct QueueNode {
    Set *data;
    struct QueueNode *next;
}QueueNode;

typedef struct Queue {
    QueueNode *front;
    QueueNode *rear;
    int count;
}Queue;

#pragma mark - 状态集合结构声明
typedef struct DFAStateSet {
    Set **stateSet;
    int count;
}DFAStateSet;

#pragma mark - DFA结构声明
typedef struct DFAStruct {
    int **dfa;
    Array *terminationState;
}DFAStruct;



#pragma mark - 正则表达实现
///主函数
void regularExpression(void) {
    
    char text[] = "ACD";
    char target[] = "((A*B|AC)D)";

    __unused bool ishave = regExp(text, target);
    


    
    
    NSLog(@"");
}

/// 正则表达式判断实现
bool regExp(char text[], char target[]) {
    int N = getStringCount(text);   /**文本长度**/
    int M = getStringCount(target);    /**正则式长度*/
    Set *charSet = initSet();   /**正则表达式的内容集合*/
    Digraph *digraphNFA = createNFA(target, M, charSet);   /**创建一个图结构,用于表示NFA的ε转换*/
    DFAStruct *DFA = createDFA(target, digraphNFA, M ,charSet);
    
    int i;  //文本位置
    int j;  //目标字符串位置
    for(i = 0, j = 0; i < N && j < M; i++) {
        j = DFA->dfa[j][text[i]];
        if(belongArray(DFA->terminationState, j)) return YES;
    }
    return NO;
}

/// 构建NFA用于判断 ε 转换
Digraph* createNFA(char target[], int M, Set *charSet) {
    Digraph *digraph = initGraph(target, M);
    
    LinkStack stack = initStack();
    for(int i = 0; i < M; i++) {
        if(target[i] != '(' && target[i] != ')' && target[i] != '|' && target[i] != '*')
            insert(charSet, (int)target[i]);

        int lp = i;
        if(target[i] == '(' || target[i] == '|') {
            pushStack(i, stack);
        }
        else if(target[i] == ')') {
            int or = popStack(stack);
            if(target[or] == '|') {
                lp = popStack(stack);
                linkGraphNode(digraph, lp, or+1);
                linkGraphNode(digraph, or, i);
            }
            else lp = or;
        }
        if (i < M-1 && target[i+1] == '*') {
            linkGraphNode(digraph, lp, i+1);
            linkGraphNode(digraph, i+1, lp);
        }
        if(target[i] == '(' || target[i] == '*' || target[i] == ')') {
            linkGraphNode(digraph, i, i+1);
        }
    }
    return digraph;
}


///将NFA转换为DFA
DFAStruct* createDFA(char target[], Digraph *digraphNFA, int M, Set *charSet) {
    //将ε转换图的集合
    Set **epsilonSet = (Set **)malloc(sizeof(Set *)*M);
    for(int i = 0; i < M; i++)
        epsilonSet[i] = epsilonChange(digraphNFA, i, M);
        
    //DFA
    DFAStruct *DFA = initDFA();
    
    Queue *stateQueue = initQueue();
    enQueue(stateQueue, epsilonSet[0]);
    
    
    //DFA状态的集合
    DFAStateSet *stateSet = initStateSet();

    //正则表达字符数组
    Array *charArray = initArray();
    treePreorderTraversal(charSet->rootNode, charArray);
    
    while (!queueEmpty(stateQueue)) {
        Set *set = deQueue(stateQueue);
        addStateSet(stateSet, set);
        for(int i = 0; i < charArray->count; i++) {
            Set *set0 = matchcConversion(set, charArray->array[i], epsilonSet, digraphNFA);
            
            if(stateSame(stateSet, set0)) {
                DFA->dfa[stateSame(stateSet, set)-1][charArray->array[i]] = stateSame(stateSet, set0)-1;   //如果有相同的，找到相同的集合的位置
            }
            else{
                enQueue(stateQueue, set0);
                DFA->dfa[stateSame(stateSet, set)-1][charArray->array[i]] = stateSet->count;
                addStateSet(stateSet, set0);
            }
            
            if(isRepetition(set0, M)) {
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




#pragma mark - 栈操作
///初始化一个栈
LinkStack initStack(void) {
    LinkStack S = (StackNode *)malloc(sizeof(StackNode));
    S->data = 123456;
    S->next = NULL;
    return S;
}
///入栈操作
void pushStack(int e, LinkStack S) {
    StackNode *topNode = (StackNode *)malloc(sizeof(StackNode));
    *topNode = *S;
    S->next = topNode;
    S->data = e;
}
///出栈操作
int popStack(LinkStack S) {
    int data = S->data;
    StackNode *node = S->next;
    S->next = node->next;
    S->data = node->data;
    free(node);
    return data;
}


#pragma mark - 图操作
///初始化图
Digraph* initGraph(char targer[], int nodeCount) {
    Digraph *graph = (VertexNode *)malloc(sizeof(VertexNode)*(nodeCount+1)); /**开辟图空间*/
    for(int i = 0; i < nodeCount; i++) {
        graph[i].data = targer[i];  /**输入顶点信息*/
        graph[i].firstedge = NULL;
        graph[i].lastedge = NULL;
    }
    //graph[nodeCount].data =
    
    return graph;
}

///连接图节点
void linkGraphNode(Digraph *graph,int tail, int head) {
    EdgeNode *Enode = (EdgeNode *)malloc(sizeof(EdgeNode));
    Enode->adjvex = head;
    Enode->next = NULL;
    if(!graph[tail].firstedge) {
        graph[tail].firstedge = Enode;
        graph[tail].lastedge = Enode;
    }
    else {
        graph[tail].lastedge->next = Enode;
        graph[tail].lastedge = Enode;
    }
}



#pragma mark - 数组操作
///数组创建初始化
Array* initArray(void) {
    Array *arr = (Array *)malloc(sizeof(Array));
    arr->array = (int *)malloc(sizeof(int)*20);
    for(int i = 0; i < 20; i++)
        arr->array[i] = '\0';
    arr->length = 20;
    arr->count = 0;
    return arr;
}

///数组添加元素
void addArray(Array *arr, int data) {
    arr->array[arr->count] = data;
    arr->count++;
    if(arr->count == arr->length) {
        int *newArr = (int *)malloc(sizeof(int)*(int)(arr->length*1.25));
        for(int i = 0; i < arr->count; i++)
            newArr[i] = arr->array[i];
        free(arr->array);
        arr->array = newArr;
    }
}

///判断某元素是否属于该数组
bool belongArray(Array *arr, int data) {
    for(int i = 0; i < arr->count; i++)
        if(arr->array[i] == data) return YES;
    return NO;
}


#pragma mark - 集合操作
///初始化集合
Set* initSet(void) {
    Set *set = (Set *)malloc(sizeof(Set));
    set->rootNode = NULL;
    set->nodeCount = 0;
    return set;
}

///插入集合数据
void insert(Set *set, int data) {
    if(!set->rootNode) {
        set->rootNode = (TreeNode *)malloc(sizeof(TreeNode));
        set->rootNode->data = data;
        set->rootNode->leftChild = NULL;
        set->rootNode->rightChild = NULL;
        set->nodeCount++;
    }
    else {
        TreeNode *node = set->rootNode;
        do {
            if(data < node->data) {
                if(node->leftChild)
                    node = node->leftChild;
                else {
                    node->leftChild = (TreeNode *)malloc(sizeof(TreeNode));
                    node->leftChild->leftChild = NULL;
                    node->leftChild->rightChild = NULL;
                    set->nodeCount++;
                    node->leftChild->data = data;break;
                }
            }
            if(data > node->data) {
                if(node->rightChild)
                    node = node->rightChild;
                else {
                    node->rightChild = (TreeNode *)malloc(sizeof(TreeNode));
                    node->rightChild->leftChild = NULL;
                    node->rightChild->rightChild = NULL;
                    set->nodeCount++;
                    node->rightChild->data = data;break;
                }
            }
            if(data == node->data)break;
        }while(node);
    }
}

///集合并集
Set* set_union(Set *set1, Set *set2) {
    Set *set = initSet();
    Array *arr1 = initArray();
    Array *arr2 = initArray();
    
    treePreorderTraversal(set1->rootNode, arr1);
    treePreorderTraversal(set2->rootNode, arr2);

    for(int i = 0; i < arr1->count; i++)
        insert(set, arr1->array[i]);
    for(int i = 0; i < arr2->count; i++)
        insert(set, arr2->array[i]);
    return set;
}

///前序遍历集合
void treePreorderTraversal(TreeNode *node, Array *arr) {
    if(node == NULL)
        return;
    addArray(arr, node->data);
    
    treePreorderTraversal(node->leftChild, arr);
    treePreorderTraversal(node->rightChild, arr);
}

///判断两个集合是否相同
bool SetSame(Set *set1, Set *set2) {
    Array *arr1 = initArray();
    Array *arr2 = initArray();
    
    treePreorderTraversal(set1->rootNode, arr1);
    treePreorderTraversal(set2->rootNode, arr2);
    
    if(arr1->count != arr2->count)
        return NO;
    else {
        for(int i = 0; i < arr1->count; i++)
            if(arr1->array[i] != arr2->array[i]) return NO;
        return YES;
    }
}

///判断集合中是否已经存储
bool isRepetition(Set *set, int adjvex) {
    Array *arr = initArray();
    treePreorderTraversal(set->rootNode, arr);
    for(int i = 0; i < arr->count; i++)
        if(arr->array[i] == adjvex) return YES;
    return NO;
}



#pragma mark - 队列操作

///队列初始化
Queue* initQueue(void) {
    Queue *Q = (Queue *)malloc(sizeof(Queue));
    Q->count = 0;
    Q->front = NULL;
    Q->rear = NULL;
    return Q;
}

///入队列
void enQueue(Queue *Q, Set *set) {
    QueueNode *node = (QueueNode *)malloc(sizeof(QueueNode));
    node->data = set;
    node->next = NULL;
    
    if(Q->rear == NULL) {
        Q->front = node;
        Q->rear = node;
    }
    else {
        Q->rear->next = node;
        Q->rear = node;
    }
    Q->count++;
}

///出队列
Set* deQueue(Queue *Q) {
    if(queueEmpty(Q))
        return NULL;
    Set *set = Q->front->data;
    QueueNode *node = Q->front;
    if(Q->front->next)
        Q->front = Q->front->next;
    else {
        Q->front = NULL;
        Q->rear = NULL;
    }
    free(node);
    Q->count--;
    
    return set;
}

///判断队列是否为空
bool queueEmpty(Queue *Q) {
    if(Q->count == 0)
        return YES;
    return NO;
}


#pragma mark - 状态集合操作
///初始化状态集合
DFAStateSet* initStateSet(void) {
    DFAStateSet *stateSet = (DFAStateSet *)malloc(sizeof(DFAStateSet));
    stateSet->stateSet = (Set **)malloc(sizeof(Set *)*100);
    stateSet->count = 0;
    return stateSet;
}

///DFA状态集合添加状态
bool addStateSet(DFAStateSet *stateSet, Set *set) {
    if(stateSame(stateSet, set))
        return NO;
    stateSet->stateSet[stateSet->count] = set;
    stateSet->count++;
    return YES;
}

///判断该状态在DFA中是否已经存在，如果存在则返回位置
int stateSame(DFAStateSet *stateSet, Set *set) {
    for(int i = 0; i < stateSet->count; i++)
        if(SetSame(stateSet->stateSet[i], set)) return i+1;
    return 0;
}

#pragma mark - DFA操作
///初始化DFA
DFAStruct* initDFA(void) {
    DFAStruct *DFA = (DFAStruct *)malloc(sizeof(DFAStruct));
    DFA->dfa = (int**)malloc(sizeof(int*)*20);
    for(int i = 0; i < 20; i++)
        DFA->dfa[i] = (int *)malloc(sizeof(int)*128);
    
    for(int i = 0; i < 20; i++)
        for(int j = 0; j < 128; j++)
            DFA->dfa[i][j] = '\0';
    
    DFA->terminationState = initArray();
    return DFA;
}


@end
