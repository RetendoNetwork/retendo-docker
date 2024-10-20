const fs = require('fs');

const config = {
    http: {
        port: 7070
    },
    mongoose: {
        connection_string: "mongodb://localhost:27017/retendo_account",
        options: {
            useNewUrlParser: true
        }
    },
    redis: {
        client: {
            url: "redis://localhost:6379"
        }
    },
    email: {
        host: "smtp.gmail.com",
        port: 587,
        secure: false,
        auth: {
            user: "username",
            pass: "password"
        },
        from: "Company Name <user@company.net>"
    },
    s3: {
        endpoint: "nyc3.digitaloceanspaces.com",
        key: "ACCESS_KEY",
        secret: "ACCESS_SECRET"
    },
    hcaptcha: {
        secret: "0x0000000000000000000000000000000000000000"
    },
    cdn: {
        base_url: "https://local-cdn.example.com",
        subdomain: "local-cdn",
        disk_path: "/home/cedke/retendo-cdn"
    },
    website_base: "https://example.com"
};

const jsonConfig = JSON.stringify(config, null, 2);
fs.writeFileSync('repos/account/account-config.json', jsonConfig);
