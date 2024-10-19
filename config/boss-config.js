const fs = require('fs');

const config = {
    config: {
        port: 86,
    },

    db: {
        "connection_string": "mongodb://127.0.0.1:27017/retendo_boss?replicaSet=rs",
        "options": {
            "useNewUrlParser": true
        }
    }
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/BOSS/boss-config.json', jsonConfig);
