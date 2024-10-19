const fs = require('fs');

const config = {
    config: {
        port: 83
    },

    db: {
        "connection_string": "mongodb://127.0.0.1:27017/retendo_account?replicaSet=rs",
        "options": {
            "useNewUrlParser": true
        }
    }
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/account/account-config.json', jsonConfig);
