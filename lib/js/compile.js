var traceur = require('traceur');
var fs = require('fs');

if (process.argv.length < 5) {
  throw "Usage: compile.js infile outfile options_as_json";
}

var infile = process.argv[2];
var outfile = process.argv[3];
var customOptions = JSON.parse(process.argv[4]);

var contents = fs.readFileSync(infile).toString();

var result;

try {
  result = traceur.compile(contents, customOptions, customOptions.filename, customOptions.filename);
} catch (error) {
  console.error(error.join("\n"));
  process.exit(1);
}

fs.writeFileSync(outfile, result);
