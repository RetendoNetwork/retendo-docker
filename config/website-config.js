const fs = require('fs');

const config = {
    config: {
        port: 82,
        url: "retendo.online"
    },
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/website/website-config.json', jsonConfig);
