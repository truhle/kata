// Returns human readable time (HH:MM:SS) from a number of seconds
// The maximum time never exceeds 359999 (99:59:59)

function humanReadable(seconds) {
  var hours = Math.floor(seconds / 3600), minutes = Math.floor(seconds % 3600 / 60), seconds = (seconds % 60);
  return pad(hours) + ":" + pad(minutes) + ":" + pad(seconds);
}

function pad(n) {
  n = n + '';
  return "00".substring(0, 2 - n.length) + n;
}

console.log(humanReadable(0))
// '00:00:00'
console.log(humanReadable(5))
// '00:00:05'
console.log(humanReadable(86399)),
// '23:59:59'
