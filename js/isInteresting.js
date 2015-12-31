//  Finds "interesting" numbers, defined as large numbers with all trailing
// zeros (eg 90000), palindromic nubmers (eg 1221), sequentially increasing
// or decreasing numbers (including those that bridge over zeros, eg 8901 or 2109),
// or numbers included in an array of "awesomePhrases".
// Returns 2 if the number is "interesting", 1 if one of the next two
// numbers will be interesting, or 0.

function isInteresting(number, awesomePhrases) {
  for (var i = number; i < number + 3; i++) {
    if ((trailingZeros(i) || sequential(i) || palindrome(i) || inAry(i, awesomePhrases)) && i > 99)
      return i == number ? 2 : 1;
  }
  return 0;
}

function inAry(number, ary) {
  var string = ary.join(", ");
  return string.indexOf(String(number)) == -1 ? false : true;
}

function palindrome(number) {
  return String(number) == String(number).split('').reverse().join('');
}

function sequential(number) {
  var digits = number.toString().split('');
  var ascending = digits.every(function(digit, i) { return Number(digit) == (Number(digits[0]) + i) % 10 });
  var descending = digits.every(function(digit, i) { return Number(digit) == Math.abs(Number(digits[0]) - i )});
  return ascending || descending;
}

function trailingZeros(number) {
  return /^\d0+$/.test(number);
}



console.log(isInteresting(1336, [1337, 256]));
// 1
console.log(isInteresting(11209, [1337, 256]));
// 1
console.log(isInteresting(100, [1337, 256]));
// 2
console.log(isInteresting(70000, [1337, 256]));
// 2
console.log(isInteresting(1234, [1337, 256]));
// 2
console.log(isInteresting(2109, [1337, 256]));
// 0
console.log(isInteresting(98, [1337, 256]));
// 1
console.log(isInteresting(99, [1337, 256]));
// 1
