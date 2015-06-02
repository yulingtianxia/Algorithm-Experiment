Algorithm-Experiment
====================

##Introduction
Algorithm experiment code written by Swift  
This is a worksapce built on target OSX 10.10. It contains several projects:  
- ConvexHull
- LCS
- Hamiltonian Cycle
- N-Queen

##Environment
OSX Yosemite  
##Projects
###ConvexHull
I solve this issue with three methods: BruteForce(O(n^4)), GrahamScan(O(nlogn)) and Divide&Conquer(O(nlogn)).   
![](http://7ni3rk.com1.z0.glb.clouddn.com/convexhull.png)
###LCS
Longest Common Sequence.  
Divide&Conquer  
Dynamic Programming  
![](http://7ni3rk.com1.z0.glb.clouddn.com/LCS1.png)  
![](http://7ni3rk.com1.z0.glb.clouddn.com/LCS2.png)  

###Hamiltonian Cycle
BaseTreeSearch:Base back tracking,cut limb that had been searched.
HillClimbing:When searching neighbours,select the node that has minimum neighbours.   
![](http://7ni3rk.com1.z0.glb.clouddn.com/QQ20141217-1@2x.png)  

###N-Queen
To save time, I implement this question with C++. The solution uses backtracking and random algorithm. 
