//
//  DataStructure.m
//  iOS总结
//
//  Created by 邓杰 on 2022/11/3.
//

#import "DataStructure.h"
#import "KMP.h"

@implementation DataStructure


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
Digraph* initGraph(StringArr *targetArr) {
    Digraph *graph = (VertexNode *)malloc(sizeof(VertexNode)*(targetArr->length+1)); /**开辟图空间*/
    for(int i = 0; i < targetArr->length; i++) {
        graph[i].data = *targetArr->stringArr[i];  /**输入顶点信息*/
        graph[i].firstedge = NULL;
        graph[i].lastedge = NULL;
    }
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
    
    if(!set2->rootNode)
        return set1;
    if(!set1->rootNode)
        return set2;
    
    
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
    for(int i = 0; i < stateSet->count; i++){
        if(!set) {
            NSLog(@"");
        }
        if(SetSame(stateSet->stateSet[i], set))
            return i+1;
    }
      
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
