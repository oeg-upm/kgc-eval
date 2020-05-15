const parser = require('rocketrml');
var fs = require('fs')

const doMapping = async () => {
  try{
    table1 = fs.readFileSync('/data/table1.csv', 'utf8')
    table2 = fs.readFileSync('/data/table2.csv', 'utf8')
    mapping = fs.readFileSync('/mappings/synthetic/standard.rml.ttl', 'utf8')
  }catch(e){
    console.log('Error:', e.stack);
  }
  let inputFiles = {
    "/data/table1.csv": table1,
    "/data/table2.csv": table2
  };
  const options = {
    toRDF: true,
    verbose: true,
    xmlPerformanceMode: false
  };
  const result = await parser.parseFileLive(mapping, inputFiles, options).catch((err) => { console.log(err); });
  fs.appendFile('/results/relation-type.nt', result, function (err) {
    if (err) throw err;
    console.log('Saved!');
  });
};

doMapping();
