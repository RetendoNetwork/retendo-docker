const fs = require('fs');

const config = {
    config: {
        port: 86,
    },
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('config/boss-config.json', jsonConfig);