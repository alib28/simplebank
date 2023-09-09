package main

import (
	"database/sql"
	"log"

	"github.com/alib28/simplebank/api"
	db "github.com/alib28/simplebank/db/sqlc"
	"github.com/alib28/simplebank/util"
	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("Cannot load config")
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)

	err = server.Start(config.ServerAddress)

	if err != nil {
		log.Fatal("Cannot start server:", err)
	}
}
