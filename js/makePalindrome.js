// A much too complicated approach to generating the shortest
// palindrome starting with a given word.

function makePalindrome(text){
  if (text.length == 1) return text;
  if (text.length == 2) return text + text[0];
  var textAry = text.split('');
  return fillOutPalindrome(findPCenter(textAry), textAry, text);
}

function fillOutPalindrome(pCenter, ary, text) {
  var  aCenter = Math.floor(ary.length / 2);
  var pCenter = pCenter.length == 1 ? pCenter[0] : (pCenter[0] + pCenter[1]) / 2;
  if (Math.floor(pCenter) == pCenter) {
    switch (findWorkEdge(pCenter, aCenter)) {
      case "left":
        ary = ary.slice((pCenter * 2) + 1).reverse().concat(ary);
        break;
      case "right":
        var offset = ary.length - (pCenter + 1);
        ary = ary.concat(ary.slice(0, pCenter - offset).reverse());
        break;
      case "center":
        return text;
        break;
    }
  }
  else {
    switch (findWorkEdge(pCenter, aCenter)) {
      case "left":
        ary = ary.slice((pCenter * 2) + 1).reverse().concat(ary);
        break;
      case "right":
        var offset = ary.length - (pCenter + 1.5);
        ary = ary.concat(ary.slice(0, pCenter - offset).reverse());
        break;
      case "center":
        return text;
        break;
    }
  }
  return ary.join('');

}

function findWorkEdge(pCenter, aCenter) {
  return pCenter < aCenter ? "left" : pCenter > aCenter ? "right" : "center";
}


function findPCenter(ary) {
  var index = [ary.length - 1], maxZ = 0;
  ary.forEach(function(char, i) {
    var result = true, z = 0;
    while (result == true) {
      if (ary[i] == ary[i + 1] && ary[i - z] == ary[i + 1 + z]) {
        if (z + 0.5 > maxZ && (i - z == 0 || i+ 1 + z == ary.length - 1)) {
          maxZ = z + 0.5;
          index = [i, i + 1];
        }
        z++;
      } else if (ary[i - z] && ary[i - z] == ary[i + z]) {
        if (z > maxZ && (i - z == 0 || i + z == ary.length - 1)) {
          maxZ = z;
          index = [i];
        }
        z++;
      }
      else {
        result = false;
      }
    }
  });
  return index;
}

console.log(makePalindrome('noontaxes'));
// 'sexatnoontaxes'

console.log(makePalindrome('abb'));
// 'abba'

// A much much more concise solution

function conciseMakePalindrome(text){
    var rev = text.split('').reverse().join('');
    for (var i = text.length; i > 0; i -= 1) {
        if (rev.slice(0, i) === text.slice(-i)) {
            return text + rev.slice(i);
        }
        if (text.slice(0, i) === rev.slice(-i)) {
            return rev + text.slice(i);
        }
    }
}
