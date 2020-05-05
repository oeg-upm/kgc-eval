const parser = require('rocketrml');
var fs = require('fs')

const doMapping = async () => {
  try{
    stops = fs.readFileSync('/data/STOPS.csv', 'utf8')
    stop_times = fs.readFileSync('/data/STOP_TIMES.csv', 'utf8')
    frequencies = fs.readFileSync('/data/FREQUENCIES.csv', 'utf8')
    calendar_dates = fs.readFileSync('/data/CALENDAR_DATES.csv', 'utf8')
    calendar = fs.readFileSync('/data/CALENDAR.csv', 'utf8')
    feed_info = fs.readFileSync('/data/FEED_INFO.csv', 'utf8')
    routes = fs.readFileSync('/data/ROUTES.csv', 'utf8')
    shapes = fs.readFileSync('/data/SHAPES.csv', 'utf8')
    trips = fs.readFileSync('/data/TRIPS.csv', 'utf8')
    agency = fs.readFileSync('/data/AGENCY.csv', 'utf8')
    mapping = fs.readFileSync('/mappings/gtfs-csv.rml.ttl', 'utf8')
  }catch(e){
    console.log('Error:', e.stack);
  }
  let inputFiles = {
    "/data/STOPS.csv": stops,
    "/data/STOP_TIMES.csv": stop_times,
    "/data/FREQUENCIES.csv": frequencies,
    "/data/CALENDAR_DATES.csv": calendar_dates,
    "/data/CALENDAR.csv": calendar,
    "/data/FEED_INFO.csv": feed_info,
    "/data/SHAPES.csv": shapes,
    "/data/TRIPS.csv": trips,
    "/data/AGENCY.csv": agency,
    "/data/ROUTES.csv": routes
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
