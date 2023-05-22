proc merge(arr, left:int, mid:int, right:int) {
	
	var i, j, k: int = 0;
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
	i = 1;
	j = 1;
	k = left;
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

proc mergesort(arr, left, right, max) {
	if (left < right) {
		var mid: int = left + (right - left) / 2;
		var size: int = right - left + 1;
		
		if (size < 256) { // seq
			mergesort(arr, left, mid, max + 1);
			mergesort(arr, mid + 1, right, max + 1);
		}
		else { // par
			serial max > here.maxTaskPar { cobegin {
				mergesort(arr, left, mid, max + 1);
				mergesort(arr, mid + 1, right, max + 1);
			} }
		}
		
		merge(arr, left, mid, right);
	}
}

// generating an array of random integers
use Random;
config const arraySize = 10000000;
var arr: [1..arraySize] int;
fillRandom(arr); // punjenje arraya brojevima [-2.147 mlrd, +2.147 mlrd]
/*
for a in arr do
	a = a % 1000000;
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

// sorting the array
writeln("SORTIRANJE");
mergesort(arr, 1, arr.size, 0);

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

/*
writeln("(Locale) here = ", here);
writeln("here.maxTaskPar = ", here.maxTaskPar);
*/
