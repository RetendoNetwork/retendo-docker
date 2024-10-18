const fs = require('fs');

const config = {
    config: {
        port: 86,
    },
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/BOSS/boss-config.json', jsonConfig);