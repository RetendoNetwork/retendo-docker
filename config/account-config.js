const fs = require('fs');

const config = {
    config: {
        port: 83
    },
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/account/account-config.json', jsonConfig);