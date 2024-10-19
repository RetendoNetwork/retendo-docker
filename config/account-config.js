const fs = require('fs');

const config = {
    config: {
        port: 81,
        url: "retendo.online"
    },
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/account/account-config.json', jsonConfig);