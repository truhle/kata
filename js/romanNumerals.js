// A roman numeral converter for numbers between 1 and 3999

function solution(number){
  var key = [['I','V'], ['X', 'L'], ['C', 'D'], ['M']]
  var number = String(number).split('').reverse();
  return number.reduce(function(acc, curr, i) {
    var place = '', codes = key[i];
    if (curr < 3 && curr > 0) {
      for (var j = 0; j < curr; j++) {
        place += codes[0];
      }
    }
    else if (curr == 4)
      place = codes[0] + codes[1];
    else if (curr >= 5 && curr < 9) {
      var offset = curr - 5;
      place = codes[1];
      for (var k = 0; k < offset; k++) {
        place += codes[0];
      }
    }
    else if (curr == 9)
      place = codes[0] + key[i+1][0];
    return place.concat(acc);
  }, '')
}

console.log(solution(1000));
// M

// A much more concise solution

function conciseSolution(number){
var  roman = {M:1000,CM:900, D:500,CD:400,C:100,XC:90,L:50,XL:40,X:10,IX:9,V:5,IV:4,I:1 }

var ans = '';
while(number>0){
    for(a in roman){
        if(roman[a]<=number){ ans += a; number-=roman[a]; break;}

    }
}
return ans;
}
