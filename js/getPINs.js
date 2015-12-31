// Returns an array of all potential combos of PINs based on an observed
// PIN, taking into account the possibility that any observed number
// might have also been the vertically or horizontally adjacent number.

function getPINs(observed) {
  var possiblesMap = { 1: ['1','2','4'], 2: ['1','2','3','5'], 3: ['2','3','6'],
                    4: ['1','4','5','7'], 5: ['2','4','5','6','8'], 6: ['3','5','6','9'],
                    7: ['4','7','8'], 8: ['5','7','8','9','0'], 9: ['6','9','8'],
                    0: ['8','0'] };
  var possibles = observed.split('').map(n => possiblesMap[n]);
  var result = [];

  function getPIN(indicies) {
    var PIN = "";
    indicies.forEach(function(index, i) {
      PIN += (possibles[i][index]);
    });
    result.push(PIN);
  }

  callManyTimes(possibles, getPIN);

  return result;
}

function callManyTimes(ary, func) {
  doCallManyTimes(ary, func, [], 0);
}

function doCallManyTimes(ary, func, args, index) {
  if (ary.length == 0) {
    func(args);
  } else {
    var rest = ary.slice(1);
    for (args[index] = 0; args[index] < ary[0].length; args[index]++)
      doCallManyTimes(rest, func, args, index + 1)
  }
}

console.log(getPINs("58"));
// [ '25', '27', '28', '29', '20', '45', '47', '48', '49', '40', '55', '57', '58', '59', '50', '65', '67', '68', '69', '60', '85', '87', '88', '89', '80' ]
