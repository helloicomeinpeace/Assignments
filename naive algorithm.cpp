#include <bits/stdc++.h> 
using namespace std; 
 
void search(string pat, string txt)  
{  
    int M = pat.size();  
    int N = txt.size();  
    int i = 0;  
  
    while (i <= N - M)  
    {  
        int j;  
  
        /* For current index i, check if match occurs */
        for (j = 0; j < M; j++)  
            if (txt[i + j] != pat[j])  
                break;  
  
        if (j == M)
        {  
            cout << "Pattern found at index " << i << endl;  
            i = i + M;  
        }  
        else if (j == 0)  
            i = i + 1;  //slide pattern by 1 index
        else
            i = i + j; //slide pattern by j indexes
    }  
}  
  
int main()  
{  
    string txt = "ABABCD";  
    string pat = "ABCD";  
    search(pat, txt);  
    return 0;  
}   