function strongEnough(earthquake, age) {
  return calcEQStrength(earthquake) > calcBldStrength(age) ? "Needs Reinforcement!" : "Safe!";
}

function calcBldStrength(age) {
  var strength = 1000;
  for (var i = 0; i < age; i++) {
    strength -= strength * 0.01;
  }
  return strength;
}

function calcEQStrength(earthquake) {
  return earthquake.reduce(function(prod, curr) {
    return prod * curr.reduce((sum, el) => sum + el);
  }, 1);
}
