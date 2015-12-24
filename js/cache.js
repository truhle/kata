// Returns a function from a function given as an argument that will
// cache the results of any given argument configuration and return
// the result from cache rather than running the function the argument
// list has been seen before.

// Ended up with a very convoluted solution in an attempt at handling void calls:

// function cache(func) {
//   var c = {};
//   return function() {
//     var sArgs = [], args = [];
//     for (var i = 0; i < arguments.length; i++) {
//         sArgs.push(JSON.stringify(arguments[i]));
//         args.push(arguments[i]);
//     }
//
//     if (arguments.length == 0) {
//       if (c['zLength123'] == 1)
//         return undefined;
//       if (c['zLength123']) return c['zLength123']; c['zLength123'] = func() || 1;
//       return c['zLength123'] == 1 ? undefined : c['zLength123'];
//     }
//     return c[sArgs] ? c[sArgs] : c[sArgs] = func.apply(null, args);
//   }
// }

// The much more elegant solution that utilizes the 'in' keyword
// and thus doesn't rely on values being "truthy".  Also acknowledges
// that one can pass the arguments object directly to the apply() function
// without converting it to a straight array.

function cache(func) {
  var calls = {};
  return function() {
    var key = JSON.stringify(arguments);
    if (!(key in calls)) {
      calls[key] = func.apply(null, arguments);
    }
    return calls[key];
  };
}



var complexFunction = function(arg1, arg2) { return arg1 + arg2 }; // "complex" function
var cachedFunction = cache(complexFunction);

console.log(cachedFunction('foo', 'bar')); // complex function should be executed
console.log(cachedFunction('foo', 'bar')); // complex function should not be invoked again, instead the cached result should be returned
console.log(cachedFunction('foo', 'baz')); // should be executed, because the method wasn't invoked before with these arguments

console.log(cachedFunction('foo', { 1: "sdf" }));

console.log(void cachedFunction());
console.log(void cachedFunction());
