// Hashtag generator

function generateHashtag (str) {
  str = str.trim();
  if (str.length == 0) return false;
  var hashTag = "#" + str.split(' ').map(function(w) {
    return w.charAt(0).toUpperCase() + w.slice(1);
  }).join('');
  return hashTag.length > 140 ? false : hashTag;
}

console.log(generateHashtag(" Hello there thanks for trying my Kata"));
// '#HelloThereThanksForTryingMyKata'
console.log(generateHashtag("hi"));
// '#Hi'
console.log(generateHashtag(''));
// false
