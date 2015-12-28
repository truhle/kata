// Produces a power set of all subsets of a given set

function power(s) {
  var result = [[], s];
  function through(set) {
    var newSets = [];
    for (var i = 0; i < set.length; i++) {
      var newSet = set.slice(0, i).concat(set.slice(i + 1, set.length));
      if (newSet.length != 0 &&
          JSON.stringify(result).indexOf(JSON.stringify(newSet)) == -1) {
        result.push(newSet);
        newSets.push(newSet);
      }
    }
    newSets.forEach(through);
  }
  through(s);
  return result;
}

console.log(power([1,2,3]));
// => [ [], [ 1, 2, 3 ], [ 2, 3 ], [ 1, 3 ], [ 1, 2 ], [ 3 ], [ 2 ], [ 1 ] ]


// a much more elegant solution

function elegantPower(s) {
  var power = [[]];
  s.forEach(function(element) {
    power.forEach(function(part) {
      power.push(part.concat(element));
    });
  });
  return power;
}
