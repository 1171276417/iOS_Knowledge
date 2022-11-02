//
//  WordSearchTree.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/24.
//

#import "WordSearchTree.h"

@implementation WordSearchTree

///树节点
typedef struct LetterNode {
    ///存储内容
    char data;
    ///节点的度数
    int degree;
    ///左孩子
    struct LetterNode *leftNode;
    ///中孩子
    struct LetterNode *midNode;
    ///右孩子
    struct LetterNode *rightNode;
} LetterNode;

///单词查找树
typedef struct SearchTree {
    ///根节点
    struct LetterNode *rootNode;
    ///当前节点
    struct LetterNode *currentNode;
}SearchTree;

int num ;


///三向单词查找树
void loadWordSearchTree(void) {
    
    
    
    
    
}

///初始化单词查找树
SearchTree *initWordSearchTree(void) {
    SearchTree *tree = (SearchTree *)malloc(sizeof(SearchTree));
    tree->rootNode->degree = 0;
    tree->rootNode->leftNode = NULL;
    tree->rootNode->midNode = NULL;
    tree->rootNode->rightNode = NULL;
    tree->currentNode = tree->rootNode;
    return tree;
}

///插入新字符串
SearchTree * insertWord(char String[] ,SearchTree *tree) {
    int i = 0;
    while (String[i] != '\0') {
        i++;
    }
    num = 0;
    
    
    return nil;
}



SearchTree * aaaa(char String[] ,SearchTree *tree) {
    if(!tree->currentNode->data) {
        tree->currentNode->data = String[num];
        num++;
        aaaa(&String[num], tree);
    }
    
    else if(String[num] < tree->currentNode->data) {
        tree->currentNode = tree->currentNode->leftNode;
        aaaa(&String[num], tree);
    }
    else if(String[num] == tree->currentNode->data) {
        tree->currentNode = tree->currentNode->midNode;
        num++;
        aaaa(&String[num], tree);
    }
    else if(String[num] > tree->currentNode->data) {
        tree->currentNode = tree->currentNode->rightNode;
        aaaa(&String[num], tree);
    }
    return tree;
}






/////进入左节点
//SearchTree * intoLeftNode(SearchTree *tree) {
//
//}
//
//
/////进入中节点
//SearchTree * intoMidNode(SearchTree *tree) {
//
//}
//
//
//
/////进入右节点
//SearchTree * intoRightNode(SearchTree *tree) {
//
//}




@end
