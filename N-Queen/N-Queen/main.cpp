//
//  main.cpp
//  N-Queen
//
//  Created by 杨萧玉 on 14/12/23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#include <iostream>
#include <vector>
#include <algorithm>
#include <map>
#include <array>
#include <stack>
#include <queue>
#include <set>
#include <math.h>
#include <stdlib.h>
#include <sstream>
#include <unordered_set>
#include <unordered_map>
#include <iomanip>
#include <numeric>
#include <limits>
#include <list>
using namespace std;
#define random(x) (rand()%x)
class Solution {
public:
    set<pair<int, int>> stack;
    vector<vector<string>> result;
    int size=0;
    vector<vector<string>> solveNQueens(int n) {
        size=n;
        backtrack(0);
        return result;
    }
    void backtrack(int i){
        if (i==size) {
            generateResult();
            return;
        }
        for (int j=0; j<size; j++) {
            if (check(i, j)) {
                stack.insert(pair<int, int>(i,j));
                backtrack(i+1);
                stack.erase(pair<int, int>(i,j));
            }
        }
    }
    void generateResult(){
        vector<string> temp(size,string(size,'_'));
        set<pair<int, int>>::iterator iter = stack.begin();
        for (; iter!=stack.end(); iter++) {
            temp[iter->first].replace(iter->second, 1, "Q");
        }
        result.push_back(temp);
    }
    bool check(int i,int j){
        set<pair<int, int>>::iterator iter = stack.begin();
        for (; iter!=stack.end(); iter++) {
            if (iter->first==i||iter->second==j||(abs(iter->first-i)==abs(iter->second-j))) {
                return false;
            }
        }
        return true;
    }
    vector<pair<int, int>> randomQueen(int n){
        vector<pair<int, int>> result;
        for (int i=0; i<n; i++) {
            result.push_back(pair<int, int>(i,random(n)));
        }
        return result;
    }
    vector<vector<string>> checkRandomRes(int n){
        size=n;
        bool success=false;
        while (!success) {
            vector<pair<int, int>> input=randomQueen(n);
            auto i=input.begin();
            stack.clear();
            bool shutdown=false;
            for (; i!=input.end()&&!shutdown; i++) {
                if (check(i->first, i->second)) {
                    stack.insert(*i);
                }
                else{
                    shutdown=true;
                }
            }
            if (!shutdown) {
                success=true;
            }
        }
        generateResult();
        return result;
    }
};

int main(int argc, const char * argv[]) {
    // insert code here...
    Solution s=Solution();
    vector<vector<string>> result=s.solveNQueens(12);//随机回溯求解N皇后
//    vector<vector<string>> result=s.checkRandomRes(12);//随机算法求解N皇后
    auto i=result.begin();
    while (i!=result.end()) {
        auto j=(*i).begin();
        while (j!=(*i).end()) {
            cout<<*j<<endl;
            j++;
        }
        cout<<"-------我是华丽的分割线------"<<endl;
        i++;
    }
    return 0;
}
