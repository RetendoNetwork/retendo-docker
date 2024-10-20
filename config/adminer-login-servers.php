<?php
require_once "plugins/login-servers.php";
/** Set supported servers
* @param array array($description => array("server" => , "driver" => "server|pgsql|sqlite|..."))
*/
return new AdminerLoginServers(
    ($servers = [
        "Retendo Postgres" => [
            "server" => "postgres",
            "driver" => "pgsql",
        ],
    ])
);