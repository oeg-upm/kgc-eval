const parser = require('rocketrml');
var fs = require('fs')

const doMapping = async () => {
  try{
    stops = fs.readFileSync('/data/STOPS.json', 'utf8')
    stop_times = fs.readFileSync('/data/STOP_TIMES.json', 'utf8')
    frequencies = fs.readFileSync('/data/FREQUENCIES.json', 'utf8')
    calendar_dates = fs.readFileSync('/data/CALENDAR_DATES.json', 'utf8')
    calendar = fs.readFileSync('/data/CALENDAR.json', 'utf8')
    feed_info = fs.readFileSync('/data/FEED_INFO.json', 'utf8')
    routes = fs.readFileSync('/data/ROUTES.json', 'utf8')
    shapes = fs.readFileSync('/data/SHAPES.json', 'utf8')
    trips = fs.readFileSync('/data/TRIPS.json', 'utf8')
    agency = fs.readFileSync('/data/AGENCY.json', 'utf8')
    mapping = fs.readFileSync('/mappings/gtfs-json.rml.ttl', 'utf8')
  }catch(e){
    console.log('Error:', e.stack);
  }
  let inputFiles = {
    "/data/STOPS.json": stops,
    "/data/STOP_TIMES.json": stop_times,
    "/data/FREQUENCIES.json": frequencies,
    "/data/CALENDAR_DATES.json": calendar_dates,
    "/data/CALENDAR.json": calendar,
    "/data/FEED_INFO.json": feed_info,
    "/data/SHAPES.json": shapes,
    "/data/TRIPS.json": trips,
    "/data/AGENCY.json": agency,
    "/data/ROUTES.json": routes
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
