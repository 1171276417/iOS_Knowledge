//
//  DataStructure.h
//  iOS总结
//
//  Created by 邓杰 on 2022/11/3.
//

#import <Foundation/Foundation.h>
#import "KMP.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataStructure : NSObject

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
    Set *_Nullable* _Nullable stateSet;
    int count;
}DFAStateSet;

#pragma mark - DFA结构声明
typedef struct DFAStruct {
    int *_Nullable* _Nullable dfa;
    Array *terminationState;
}DFAStruct;






LinkStack initStack(void);
void pushStack(int e, LinkStack S);
int popStack(LinkStack S);


Digraph* initGraph(StringArr *targetArr);
void linkGraphNode(Digraph *graph,int tail, int head);


Array* initArray(void);
void addArray(Array *arr, int data);
bool belongArray(Array *arr, int data);


Set* initSet(void);
void insert(Set *set, int data);
Set* set_union(Set *set1, Set *set2);
void treePreorderTraversal(TreeNode *node, Array *arr);
bool SetSame(Set *set1, Set *set2);
bool isRepetition(Set *set, int adjvex);


Queue* initQueue(void);
void enQueue(Queue *Q, Set *set);
Set* deQueue(Queue *Q);
bool queueEmpty(Queue *Q);


DFAStateSet* initStateSet(void);
bool addStateSet(DFAStateSet *stateSet, Set *set);
int stateSame(DFAStateSet *stateSet, Set *set);


DFAStruct* initDFA(void);









@end

NS_ASSUME_NONNULL_END
