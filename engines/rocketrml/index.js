const rmlParser = require("rocketrml");
(async() => { 
    const result = await rmlParser.parseFile("/mappings/mapping.ttl", "/results/result.ttl", {toRDF: true, verbose:true}).catch((err) => {
        console.log(err);
    });
})()