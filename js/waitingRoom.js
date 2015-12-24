function lastChair(N){
  var chairs = [];
  for (var i = 0; i < N; i++) {
    chairs[i] = false;
  }
  var lastChair = 1;
  function findChair(chairs) {
    if (!chairs.some(function(chair) {return chair == false;})) {
      return lastChair;
    }
    else {
      var occupied = chairs.map(function (chair, i) {
        if (chair == false) return -1;
        else return i;
      }).filter(function(val) { return val >= 0; });
      if (occupied.length == 0) {
        chairs[0] = true;
        lastChair = 1;
        return findChair(chairs);
      }
      else if (occupied.length == 1) {
        chairs[N - 1] = true;
        lastChair = N;
        return findChair(chairs);
      }
      else {
        var chair = 0;
        var maxDif = 0;
        for (var i = 0; i < occupied.length - 1; i++) {
          var dif = occupied[i + 1] - occupied[i];
          if (dif > maxDif) {
            maxDif = dif;
            chair = Math.floor(occupied[i + 1] - dif / 2);
          }
        }
        chairs[chair] = true;
        lastChair = chair + 1;
        return findChair(chairs);
      }
    }
  }
  return findChair(chairs);
}

console.log(lastChair(10));

// Or for a very easy solution with no chair calculations at all

function lastChairEasy(N) {
  if (N == 1) return 1;
  else if (N == 2) return 2;
  else return N - 1;
}
