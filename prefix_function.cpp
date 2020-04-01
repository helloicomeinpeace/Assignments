#include <iostream>
#include <vector>
#include <bits/stdc++.h> 
using namespace std;
void display(vector<int> pi)
{
	for(int i=0;i<pi.size();i++)
	{
	cout<<pi[i]<<", ";
	}
}
vector<int> prefix_function(string s) {
    int n = (int)s.length();
    vector<int> pi(n);
    for (int i = 1; i < n; i++) {
        int j = pi[i-1];
        while (j > 0 && s[i] != s[j])
            j = pi[j-1];
        if (s[i] == s[j])
            j++;
        pi[i] = j;
    }
    return pi;
}

int main()
{
vector<int> pi=prefix_function("aabaabcab");
display(pi);
	
}
