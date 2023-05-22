use Random;
use Time only getCurrentTime, sleep;

proc bS(arr: [] int, size: int) {
    var i, temp, phase: int;

    for phase in 1..size {
        if (phase % 2 == 0) {
            forall i in 1..(size-1) by 2 {
            
                if (arr[i] > arr[i+1]) {
                    arr[i] <=> arr[i+1];
                    
                }
            }
        } else {
            forall i in 2..(size-1) by 2 {
                if (arr[i] > arr[i+1]) {
                    
                    arr[i] <=> arr[i+1];
                    
                }
            }
        }
    }
}


proc main()
{
    var workers: int = here.maxTaskPar;
    var sizeOfArray:int = 10000;
    var sortingList: [1..sizeOfArray] int;
    fillRandom(sortingList, 0, sizeOfArray, getCurrentTime(): int);
    coforall i in 1..workers {
        bS(sortingList, sizeOfArray);
    }
}
