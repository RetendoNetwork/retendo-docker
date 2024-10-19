try {
    const status = rs.status();
    if (status.hasOwnProperty("myState") && status.myState == 1) {
        print("Replica set is already initiated. Exiting...");
        quit();
    }
} catch (error) {
    print("Replica set not initiated. Proceeding...");
}

rs.initiate({
    _id: "rs",
    members: [
        {
            _id: 0,
            host: "mongodb:27017",
        },
    ],
});