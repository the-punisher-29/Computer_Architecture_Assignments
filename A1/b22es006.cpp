#include <iostream>
#include <vector>
#include <algorithm>
#include <chrono> 

using namespace std;
using namespace std::chrono;//for time cal

//using less efficient(for large inputs) sorting algo-bubblesort-O(n^2)
void bub_srt(vector<int>& arr) {
    int n = arr.size();
    for (int i=0;i<n-1;++i) {
        for (int j=0;j<n-i-1;++j) {
            if (arr[j]>arr[j + 1]) {
                swap(arr[j], arr[j+1]);
            }
        }
    }
}

int main() {
    const int size= 100000;
    vector<int> arr(size);
    //filling the array with random inputs
    for (int i=0;i<size;++i) {
        arr[i]=rand();
    }
    auto start = high_resolution_clock::now();// Record the start time
    bub_srt(arr);//main process
    auto end = high_resolution_clock::now();// Record the end time
    auto duration = duration_cast<milliseconds>(end - start);
    cout << "Array sorted in "<<(duration.count())/1000<<" seconds"<<endl;
    return 0;
}
