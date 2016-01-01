// Sums two numbers in string form.  Can be used for very long numbers // without converting to exponential notations.

function sumStrings(a,b) {
  var longer = (a.length >= b.length ? a : b).split('').reverse();
  var shorter = (b.length <= a.length ? b : a).split('').reverse();
  var remainder = 0;

  var answer = longer.reduce(function(acc, curr, i) {
    var curr = Number(curr) + remainder, shorterCurr = Number(shorter[i]);
    if (!isNaN(shorterCurr)) {
      var sum = curr + shorterCurr;
      if (sum - 10 > -1) {
        remainder = 1;
        return (sum - 10) + acc;
      } else {
        remainder = 0;
        return sum + acc;
      }
    }
    else {
      remainder = 0;
      return curr + acc;
    }
  }, '').replace(/^0*/, '');

  answer = answer == '' ? '0' : answer;

  return remainder == 1 ? remainder + answer : answer;
}

console.log(sumStrings("123", "456"));
// 579
console.log(sumStrings("8797", "45"));
// 8842
console.log(sumStrings("0", "0"));
// 0
console.log(sumStrings("0923579", "0439839"));
// 1363418
console.log(sumStrings("1275892387689071389476890134897869348374", "23849097680179093890409"));
// 1275892387689071413325987815076963238783
