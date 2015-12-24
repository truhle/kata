var splitInParts = function(s, partLength){

  var nParts = Math.floor(s.length / partLength);
  if (s.length % partLength > 0)
    nParts += 1;

  var partsArray = [];
  for (var i = 0; i < nParts; i++)
    partsArray.push("");

  var sArray = s.split("");
  for (var i = 0; i < sArray.length; i++) {
    var partIndex = Math.floor(i / partLength);
    partsArray[partIndex] += sArray[i];
  }

  return partsArray.join(" ");
}

console.log(splitInParts("sdhfjkjwehr", 2));
