// Returns the index of the single heavier ball from a set of 8 balls with only
// two weighings.

function findBall(scales) {
  var sets = [[0, 1, 2], [6, 7], [3, 4, 5]], firstResult;
  firstResult = scales.getWeight(sets[0], sets[2]);
  if (firstResult == 0) {
    var result = scales.getWeight([sets[1][0]], [sets[1][1]]);
    return result == -1 ? sets[1][0] : sets[1][1];
  } else {
    var i = firstResult + 1;
    var result = scales.getWeight([sets[i][0]], [sets[i][2]]);
    return result == -1 ? sets[i][0] : result == 0 ? sets[i][1] : sets[i][2];
  }
}

var scales = {
  getWeight : function(left, right) {
    var weights = [2,2,2,2,2,2,8,2], leftTotal, rightTotal;
    leftTotal = left.reduce(function(sum, el) { return sum + weights[el]}, 0);
    rightTotal =  right.reduce(function(sum, el) { return sum + weights[el]}, 0);
    return leftTotal == rightTotal ? 0 : leftTotal > rightTotal ? -1 : 1;
  }
}

console.log(findBall(scales));
// 6
