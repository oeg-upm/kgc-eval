const parser = require('rocketrml');
var fs = require('fs')

const doMapping = async () => {
  try{
    stops = fs.readFileSync('/data/STOPS.csv', 'utf8')
    stop_times = fs.readFileSync('/data/STOP_TIMES.csv', 'utf8')
    mapping = fs.readFileSync('/mappings/synthetic/join-selectivity.rml.ttl', 'utf8')
  }catch(e){
    console.log('Error:', e.stack);
  }
  let inputFiles = {
    "/data/table1.csv": agency,
    "/data/table2.csv": routes
  };
  const options = {
    toRDF: true,
    verbose: true,
    xmlPerformanceMode: false
  };
  const result = await parser.parseFileLive(mapping, inputFiles, options).catch((err) => { console.log(err); });
  fs.appendFile('/results/gtfs.nt', result, function (err) {
    if (err) throw err;
    console.log('Saved!');
  });
};

doMapping();
