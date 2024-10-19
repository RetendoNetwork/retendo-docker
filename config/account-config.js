const fs = require('fs');

const config = {
    config: {
        port: 86
    },

    db: {
        connection_string: "mongodb://127.0.0.1:27017/retendo_boss?replicaSet=rs",
        options: {
            useNewUrlParser: true
        }
    },

    s3: {
        endpoint: "nyc3.digitaloceanspaces.com",
        key: "ACCESS_KEY",
        secret: "ACCESS_SECRET"
    },

    cdn: {
        base_url: "https://cdn.retendo.online"
    }
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/account/account-config.json', jsonConfig);
