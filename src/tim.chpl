var RUN: int = 32;

// insertion sort arraya
proc insertionsort(arr, left:int, right:int) {
	for i in left+1..right {
		var temp: int = arr(i);
		var j: int = i - 1;
		while (j >= left && arr(j) > temp) {
			arr(j + 1) = arr(j);
			j -= 1;
		}
		arr(j + 1) = temp;
	}
}

// merge funkcija za mergeanje sortiranih RUNova
proc merge(arr, left:int, mid:int, right:int) {
	
	var left_length: int = mid - left + 1; // [left, mid]
	var right_length: int = right - mid;   // [mid + 1, right]
	
	// creating temp arrays
	var left_arr: [1..left_length] int;
	var right_arr: [1..right_length] int;
	
	// copying data to temp arrays
	for i in 1..left_length do
		left_arr(i) = arr(left + i - 1);
	for j in 1..right_length do
		right_arr(j) = arr(mid + j);
		
	// merging data back into the given array
	var i: int = 1;
	var j: int = 1;
	var k: int = left;
	
	// comparing data from both temp arrays
	while (i <= left_length && j <= right_length) {
		if (left_arr(i) <= right_arr(j)) {
			arr(k) = left_arr(i);
			i += 1;
		} 
		else {
			arr(k) = right_arr(j);
			j += 1;
		}
		k += 1;
	}
	// loading arr with remaining data from the unfinished temp array
	while (i <= left_length) {
		arr(k) = left_arr(i);
		i += 1;
		k += 1;
	}
	while (j <= right_length) {
		arr(k) = right_arr(j);
		j += 1;
		k += 1;
	}	
}

// timsort
proc timsort(arr, n:int) {
	// sort individual RUNs
	var numOfRuns: int = n / RUN;
	var remainder: int = n - numOfRuns * RUN;
	var forUpperLimit: int;
	if (remainder == 0) then
		forUpperLimit = numOfRuns;
	else
		forUpperLimit = numOfRuns + 1;
	//writeln("numOfRuns = ", numOfRuns);
	//writeln("remainder = ", remainder);
	writeln("brojChunkova = ", forUpperLimit);
	coforall i in 1..forUpperLimit {
		//writeln("pocinje sort u chunku ", i);
		insertionsort(arr, (i - 1) * RUN + 1, min( (i * RUN), (n) ));
	}

	writeln("gotovo sortiranje, krece tim-merge");
	
	//
	var size: int = RUN;
	while (size < n) {
		
		var beg: int = 1;
		while (beg <= n) {
			
			// beg is starting point of left sub array
			var mid: int = beg + size - 1; // ending point of left sub array
			// starting point of right sub array is mid + 1
			var end: int = min( (beg + 2*size - 1), (n) ); // ending point of right sub array
			
			// merge left (arr[beg..mid]) and right (arr[mid+1..end]) sub array
			if (mid < end) {
				merge(arr, beg, mid, end);
			}
			
			beg = beg + 2 * size;
		}
		
		size *= 2;
	}
}

// generating an array of random integers
use Random;
config const arraySize = 100;
RUN = sqrt(arraySize): int;
writeln("RUN = sqrt(arraySize): int = ", RUN);
while (arraySize % RUN > 0) {
	RUN += 1;
}
writeln("RUN = ", RUN);
var arr: [1..arraySize] int;
fillRandom(arr); // punjenje arraya brojevima [-2.147 mlrd, +2.147 mlrd]

/*
for a in arr do
	a = a % 100;
*/

// checking if the array is sorted
var sorted: int = 1;
for i in 1..arr.size-1 {
	if arr(i) > arr(i + 1) then
		sorted = 0;
}
if sorted then
	writeln("sorted = true");
else
	writeln("sorted = false");
//writeln(arr);

// sorting the array
writeln("SORTIRANJE");
timsort(arr, arraySize);


/* TESTIRANJE insertionsort() i merge()
insertionsort(arr, 1, 50);
insertionsort(arr, 51, 100);
merge(arr, 1, 50, 100);
*/

// checking if the array truly is sorted
sorted = 1;
for i in 1..arr.size-1 {
	if arr(i) > arr(i + 1) then
		sorted = 0;
}
if sorted then
	writeln("sorted = true");
else
	writeln("sorted = false");
//writeln(arr);

/*
writeln("(Locale) here = ", here);
writeln("here.maxTaskPar = ", here.maxTaskPar);
*/

















