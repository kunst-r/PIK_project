use Random;
use Time only getCurrentTime, sleep;
use Memory;
use VisualDebug;

config var limit = 1;
config param DefaultVisualDebugOn=true;

proc quicksort(ref A: [] int, first: int, last: int, max: int, level: int) 
{
    if((last - first) >= 8) {
        var pivot = pivotElection(A, first, (last + first)/2, last);
        var i = first;
        var j = last - 1;
        while(true) {
            i = i + 1;
            while(A[i] < pivot) {
                i = i + 1;
            }
            j = j - 1;
            while(A[j] > pivot) {
                j = j - 1;
            }
            if(i < j) {
                A[i] <=> A[j];
            }
            else {
                break;
            }
        }
        A[i] <=> A[last - 1];

        serial max <= 0 {
            cobegin{
                quicksort(A, first, i - 1, max - 1, level + 1);
                quicksort(A, i + 1, last, max - 1, level + 1);
            }
        }
    }
    else {
        insertionSort(A, first, last);
    }
}

proc pivotElection(ref A: [] int, first: int, middle:int, last:int) ref
{
    if(A[first] > A[middle]) {
        A[first] <=> A[middle];
    }
    if(A[first] > A[last]) {
        A[first] <=> A[last];
    }
    if(A[middle] > A[last]) {
        A[middle] <=> A[last];
    }
    A[middle] <=> A[last - 1];
    return A[last - 1];
}

proc insertionSort (ref A: [] int, left, right: int)
{
    var i, j, temp : int;
    for i in left..right {
        temp = A[i];
        j = i;
        while(j > left && A[j - 1] > temp) {
            A[j] = A[j - 1];
            j = j - 1;
        }
        A[j] = temp;
    }
}

proc main()
{
    var maxTask: int = here.maxTaskPar;
    var sizeOfArray:int = 20000000;
    var sortingList: [1..sizeOfArray] int;
    fillRandom(sortingList, 0, sizeOfArray, getCurrentTime(): int);
    quicksort(sortingList, 1, sizeOfArray, maxTask, 1);
}
