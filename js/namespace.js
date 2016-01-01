// Creates nested objects within a root object, creating namespaces for given values.
// If no value is given, the value at the given namespace is returned, if it exists,
// else "undefined" is returned.

function namespace(root, path, value){
  var pathNames = path.split('.'), object = false;
  if (typeof value == 'object' && value !== null) {
    value = convertToText(value);
    var object = true;
  }
  if (value || value === null) {
    pathNames.forEach(function(name, i) {
      var path = makePath(pathNames.slice(0, i + 1));
      if (!eval(path) && i < pathNames.length - 1)
        eval(path + " = " + '{};');
      else if (object)
        eval(path + " = " + value + ";");
      else
        eval(path + " = '" + value + "';");
    });
  }
  else {
    for (var i = 0; i < pathNames.length; i++) {
      var path = makePath(pathNames.slice(0, i + 1));
      if (eval(path) == undefined && i < pathNames.length - 1)
        return undefined;
      else if (i == pathNames.length - 1)
        return eval(path);
    };
  }
}

function convertToText(obj) {
    var string = [];
    if (typeof(obj) == "object" && (obj.join == undefined)) {
        string.push("{");
        var propNames = [];
        for (prop in obj) {
          propNames.push(prop)
        };
        propNames.forEach(function(name, i) {
          if (i != propNames.length - 1)
            string.push(name, ": ", convertToText(obj[name]));
          else
            string.push(name, ": ", convertToText(obj[name], ",\n"))
        });
        string.push("}");
    }
    else if (typeof(obj) == "object" && !(obj.join == undefined)) {
        string.push("[")
        for(prop in obj) {
            string.push(convertToText(obj[prop]), ",");
        }
        string.push("]")
    }
    else if (typeof(obj) == "function") {
        string.push(obj.toString())

    }
    else {
        string.push(JSON.stringify(obj))
    }
    return string.join("")
}

function makePath(names) {
  var path = "root";
  names.forEach(function(name) {
    path += "['" + name + "']";
  });
  return path;
}

var stuff = {};
var otherstuff = {}
namespace(stuff, 'moreStuff.name.that', 'that name');
console.log(namespace(stuff, 'moreStuff.name.that'))
// that name
namespace(otherstuff, 'moreStuff.name.that', null);
console.log(namespace(otherstuff, 'moreStuff.name.that'));
// null
console.log(namespace(otherstuff, "notthere.nothtere"));
// undefined
var that = {};
namespace(that, 'items.things', {name: 'the thing'});
console.log(namespace(that, 'items.things.name'));
// the thing
