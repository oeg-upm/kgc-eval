const parser = require('rocketrml');
var fs = require('fs')

const doMapping = async () => {
  try{
    stops = fs.readFileSync('STOPS.csv', 'utf8')
    stop_times = fs.readFileSync('STOP_TIMES.csv', 'utf8')
    frequencies = fs.readFileSync('FREQUENCIES.csv', 'utf8')
    calendar_dates = fs.readFileSync('CALENDAR_DATES.csv', 'utf8')
    calendar = fs.readFileSync('CALENDAR.csv', 'utf8')
    feed_info = fs.readFileSync('FEED_INFO.csv', 'utf8')
    routes = fs.readFileSync('ROUTES.csv', 'utf8')
    shapes = fs.readFileSync('SHAPES.csv', 'utf8')
    trips = fs.readFileSync('TRIPS.csv', 'utf8')
    agency = fs.readFileSync('AGENCY.csv', 'utf8')
    mapping = fs.readFileSync('mapping.rml.ttl', 'utf8')
  }catch(e){
    console.log('Error:', e.stack);
  }
  let inputFiles = {
    "STOPS.csv": stops,
    "STOP_TIMES.csv": stop_times,
    "FREQUENCIES.csv": frequencies,
    "CALENDAR_DATES.csv": calendar_dates,
    "CALENDAR.csv": calendar,
    "FEED_INFO.csv": feed_info,
    "SHAPES.csv": shapes,
    "TRIPS.csv": trips,
    "AGENCY.csv": agency,
    "ROUTES.csv": routes
  };
  const options = {
    toRDF: true,
    verbose: true,
    xmlPerformanceMode: false
  };
  const result = await parser.parseFileLive(mapping, inputFiles, options).catch((err) => { console.log(err); });
  fs.appendFile('output.nt', result, function (err) {
    if (err) throw err;
    console.log('Saved!');
  });
};

doMapping();