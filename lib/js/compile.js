var traceur = require('traceur');
var fs = require('fs');

if (process.argv.length < 5) {
  throw "Usage: compile.js infile outfile options_as_json";
}

var infile = process.argv[2];
var outfile = process.argv[3];
var customOptions = JSON.parse(process.argv[4]);

var contents = fs.readFileSync(infile).toString();

var options = {
  filename: infile
};

for (var key in customOptions) {
  if (customOptions.hasOwnProperty(key)) {
    options[key] = customOptions[key];
  }
}

var result = traceur.compile(contents, options);

if (result.error) {
  throw result.error;
}

fs.writeFileSync(outfile, result.js);
fs.writeFileSync(outfile + '.map', result.sourceMap);
