// Calculates the number of keypresses required to
// enter a phrase with an old-school feature phone.


function presses(phrase) {
  var layout = ["1", "ABC2", "DEF3", "GHI4", "JKL5", "MNO6", "PQRS7", "TUV8", "WXYZ9", "*", " 0", "#"];
  var phraseAry = phrase.toUpperCase().split("");
  var keypresses = 0;
  for (var i = 0; i < phraseAry.length; i++) {
    for (var j = 0; j < layout.length; j++) {
      var keyIndex = layout[j].indexOf(phraseAry[i]);
      if (keyIndex == -1)
        continue;
      else {
        keypresses += keyIndex + 1; 
        break;
      }
    }
  }
  return keypresses;
}
