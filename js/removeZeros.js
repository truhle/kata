// Shifts all zeros to the end of an array without using Array.prototype
// methods or using temporary arrays or objects, retaining the order
// of the "zero" elements (eg [0, "0", 0]).

function removeZeros(array) {
  var end = array.length - 1;
  var count = countNonZeros(array);
  for (var i = 0; i < count; i++) {
    var el = array[i];
    while ((el == 0 || el == '0')) {
      for (var j = i; j < array.length - 1; j++) {
        array[j] = array[j + 1];
      }
      array[end] = el;
      el = array[i];
    }
  }
  return array;
}

function countNonZeros(array) {
  var count = 0
  for (var i = array.length - 1; i >= 0; i--) {
    var el = array[i];
    if (el > 0 || typeof(el) == 'object')
      count++;
  }
  return count;
}

var input = [7, 2, 3, 0, 4, 6, 0, 0, 13, 0, 78, 0, 0, 19, 14];
var input2 = [{"a":["code"]},0,{"b":["wars"]},1];

console.log(removeZeros(input));
// [ 7, 2, 3, 4, 6, 13, 78, 19, 14, 0, 0, 0, 0, 0, 0 ]
console.log(removeZeros(input2));
// [ { a: [ 'code' ] }, { b: [ 'wars' ] }, 1, 0 ]
