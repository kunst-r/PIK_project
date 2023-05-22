use Random;

proc countingSort(arr: [], exp1, min, el_range) {
    var n = arr.size;

    var output: [0..n-1] int;

    var count: [0..el_range] int;

    for i in 0..n-1 {
        count[arr[i]-min] += 1;
    }

    for i in 1..count.size-1 {
        count[i] += count[i - 1];
    }

    for i in 0..n-1 {
        output[count[arr[i] - min] - 1] = arr[i];
        count[arr[i] - min] -= 1;
    }

    for i in 0..arr.size-1 {
        arr[i] = output[i];
    }

}

proc sequentialRadixSort(arr: []){
    var max = max reduce(arr);
    var min = min reduce(arr);

    var el_range = max - min + 1;

    var exp = 1;
    while (max / exp) >= 1{
        countingSort(arr, exp, min, el_range);
        exp *= 10;
    }
}

proc main() {

  var arr: [0..100000] int;

  fillRandom(arr, -200000000, 200000000);

  sequentialRadixSort(arr);
}
