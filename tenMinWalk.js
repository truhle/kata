// Calculates whether a walk has 10 segments and
// brings one back to the place one began

function isValidWalk(walk) {
  var northSouth = 0, westEast = 0;
  walk.forEach(function(direction) {
    switch(direction) {
      case "n":
        northSouth += 1;
        break;
      case "s":
        northSouth -= 1;
        break;
      case "w":
        westEast += 1;
        break;
      case "e":
        westEast -= 1;
        break;
    }
  });
  return northSouth == 0 && westEast == 0 && walk.length == 10;
}
