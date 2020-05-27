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
    table10 = fs.readFileSync('/data/table10.csv', 'utf8')
    table11 = fs.readFileSync('/data/table11.csv', 'utf8')
    table12 = fs.readFileSync('/data/table12.csv', 'utf8')
    table13 = fs.readFileSync('/data/table13.csv', 'utf8')
    table14 = fs.readFileSync('/data/table14.csv', 'utf8')
    table15 = fs.readFileSync('/data/table15.csv', 'utf8')
    table16 = fs.readFileSync('/data/table16.csv', 'utf8')
    table17 = fs.readFileSync('/data/table17.csv', 'utf8')
    table18 = fs.readFileSync('/data/table18.csv', 'utf8')
    table19 = fs.readFileSync('/data/table19.csv', 'utf8')
    table20 = fs.readFileSync('/data/table20.csv', 'utf8')
    table21 = fs.readFileSync('/data/table21.csv', 'utf8')
    table22 = fs.readFileSync('/data/table22.csv', 'utf8')
    table23 = fs.readFileSync('/data/table23.csv', 'utf8')
    table24 = fs.readFileSync('/data/table24.csv', 'utf8')
    table25 = fs.readFileSync('/data/table25.csv', 'utf8')
    table26 = fs.readFileSync('/data/table26.csv', 'utf8')
    table27 = fs.readFileSync('/data/table27.csv', 'utf8')
    table28 = fs.readFileSync('/data/table28.csv', 'utf8')
    table29 = fs.readFileSync('/data/table29.csv', 'utf8')
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
    "/data/table9.csv": table9,
    "/data/table10.csv": table10,
    "/data/table11.csv": table11,
    "/data/table12.csv": table12,
    "/data/table13.csv": table13,
    "/data/table14.csv": table14,
    "/data/table15.csv": table15,
    "/data/table16.csv": table16,
    "/data/table17.csv": table17,
    "/data/table18.csv": table18,
    "/data/table19.csv": table19, 
    "/data/table20.csv": table20,
    "/data/table21.csv": table21,
    "/data/table22.csv": table22,
    "/data/table23.csv": table23,
    "/data/table24.csv": table24,
    "/data/table25.csv": table25,
    "/data/table26.csv": table26,
    "/data/table27.csv": table27,
    "/data/table28.csv": table28,
    "/data/table29.csv": table29
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
