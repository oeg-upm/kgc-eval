const parser = require('rocketrml');
var fs = require('fs')

const doMapping = async () => {
  try{
    table0 = fs.readFileSync('/data/table0.csv', 'utf8')
    table1 = fs.readFileSync('/data/table1.csv', 'utf8')
    table2 = fs.readFileSync('/data/table2.csv', 'utf8')
    table3 = fs.readFileSync('/data/table3.csv', 'utf8')
    table4 = fs.readFileSync('/data/table4.csv', 'utf8')
    table5 = fs.readFileSync('/data/table5.csv', 'utf8')
    table6 = fs.readFileSync('/data/table6.csv', 'utf8')
    table7 = fs.readFileSync('/data/table7.csv', 'utf8')
    table8 = fs.readFileSync('/data/table8.csv', 'utf8')
    table9 = fs.readFileSync('/data/table9.csv', 'utf8')
    mapping = fs.readFileSync('/mappings/synthetic/horizontal_with_dup_worst_case.rml.ttl', 'utf8')
  }catch(e){
    console.log('Error:', e.stack);
  }
  let inputFiles = {
    "/data/table0.csv": table0,
    "/data/table1.csv": table1,
    "/data/table2.csv": table2,
    "/data/table3.csv": table3,
    "/data/table4.csv": table4,
    "/data/table5.csv": table5,
    "/data/table6.csv": table6,
    "/data/table7.csv": table7,
    "/data/table8.csv": table8,
    "/data/table9.csv": table9 
  };
  const options = {
    toRDF: true,
    verbose: true,
    xmlPerformanceMode: false
  };
  const result = await parser.parseFileLive(mapping, inputFiles, options).catch((err) => { console.log(err); });
  fs.appendFile('/results/partitioning.nt', result, function (err) {
    if (err) throw err;
    console.log('Saved!');
  });
};

doMapping();
