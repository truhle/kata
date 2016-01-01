// Counts the number of coin combinations from a given list of denominations
// that add up to given anount.

var countChange = function(money, coins) {
  if (money < 0 || coins.length == 0)
    return 0
  else if(money == 0)
    return 1
  else
    return countChange(money - coins[0], coins) + countChange(money, coins.slice(1))
}

console.log(countChange(100, [1,5,10,25]));
// 242
console.log(countChange(50, [1,2,3,5]));
// 947
console.log(countChange(0, [1,2,3,4]));
// 1 
