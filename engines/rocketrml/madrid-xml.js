const parser = require('rocketrml');
var fs = require('fs')

const doMapping = async () => {
  try{
    stops = fs.readFileSync('/data/STOPS.xml', 'utf8')
    stop_times = fs.readFileSync('/data/STOP_TIMES.xml', 'utf8')
    frequencies = fs.readFileSync('/data/FREQUENCIES.xml', 'utf8')
    calendar_dates = fs.readFileSync('/data/CALENDAR_DATES.xml', 'utf8')
    calendar = fs.readFileSync('/data/CALENDAR.xml', 'utf8')
    feed_info = fs.readFileSync('/data/FEED_INFO.xml', 'utf8')
    routes = fs.readFileSync('/data/ROUTES.xml', 'utf8')
    shapes = fs.readFileSync('/data/SHAPES.xml', 'utf8')
    trips = fs.readFileSync('/data/TRIPS.xml', 'utf8')
    agency = fs.readFileSync('/data/AGENCY.xml', 'utf8')
    mapping = fs.readFileSync('/mappings/gtfs-xml.rml.ttl', 'utf8')
  }catch(e){
    console.log('Error:', e.stack);
  }
  let inputFiles = {
    "/data/STOPS.xml": stops,
    "/data/STOP_TIMES.xml": stop_times,
    "/data/FREQUENCIES.xml": frequencies,
    "/data/CALENDAR_DATES.xml": calendar_dates,
    "/data/CALENDAR.xml": calendar,
    "/data/FEED_INFO.xml": feed_info,
    "/data/SHAPES.xml": shapes,
    "/data/TRIPS.xml": trips,
    "/data/AGENCY.xml": agency,
    "/data/ROUTES.xml": routes
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
