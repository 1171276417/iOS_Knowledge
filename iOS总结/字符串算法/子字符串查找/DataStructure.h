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




#pragma mark - 栈方法
/// 初始化栈
LinkStack initStack(void);

/// 入栈
/// - Parameters:
///   - e: 入栈元素
///   - S: 栈结构
void pushStack(int e, LinkStack S);

/// 出栈
/// - Parameter S: 栈结构
int popStack(LinkStack S);


#pragma mark - 图方法
/// 初始化图
/// - Parameter targetArr: 图结点数组
Digraph* initGraph(StringArr *targetArr);

/// 连接图结点
/// - Parameters:
///   - graph: 图结构
///   - tail: 尾结点
///   - head: 头结点
void linkGraphNode(Digraph *graph,int tail, int head);


#pragma mark - 数组方法
/// 初始化数组
Array* initArray(void);

/// 添加数组元素
/// - Parameters:
///   - arr: 数组对象
///   - data: 添加的元素
void addArray(Array *arr, int data);

/// 判断该元素是否存在于该数组
/// - Parameters:
///   - arr: 数组对象
///   - data: 查询数据
bool belongArray(Array *arr, int data);



#pragma mark - 集合方法
/// 初始化集合
Set* initSet(void);

/// 插入集合元素
/// - Parameters:
///   - set: 集合对象
///   - data: 插入数据
void insert(Set *set, int data);

/// 求集合并集
/// - Parameters:
///   - set1: 集合1
///   - set2: 集合2
Set* set_union(Set *set1, Set *set2);

/// 前序遍历集合，将结果存入数组中
/// - Parameters:
///   - node: 集合数的根结点
///   - arr: 存储数组
void treePreorderTraversal(TreeNode *node, Array *arr);

/// 判断两个集合是否相同
/// - Parameters:
///   - set1: 集合1
///   - set2: 集合2
bool SetSame(Set *set1, Set *set2);

/// 判断集合中是否有查询对象
/// - Parameters:
///   - set: 集合对象
///   - adjvex: 查询对象
bool isRepetition(Set *set, int adjvex);


#pragma mark - 队列方法
/// 初始化队列
Queue* initQueue(void);

/// 入队列
/// - Parameters:
///   - Q: 队列对象
///   - set: 入队元素
void enQueue(Queue *Q, Set *set);

/// 出队列
/// - Parameter Q: 队列对象
Set* _Nullable  deQueue(Queue *Q);

/// 判断队列是否为空
/// - Parameter Q: 队列对象
bool queueEmpty(Queue *Q);



#pragma mark - 状态集合方法
/// 初始化状态集合
DFAStateSet* initStateSet(void);

/// 向集合中添加一个状态，返回是否添加成功
/// - Parameters:
///   - stateSet: 状态集合
///   - set: 添加的状态
bool addStateSet(DFAStateSet *stateSet, Set *set);

/// 判断集合中是否有该状态
/// - Parameters:
///   - stateSet: 状态集合对象
///   - set: 判断的状态
int stateSame(DFAStateSet *stateSet, Set *set);



/// 初始化DFA
DFAStruct* initDFA(void);









@end

NS_ASSUME_NONNULL_END
