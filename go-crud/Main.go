package main

import (
	"database/sql"
	"log"
	"net/http"

	"go-crud/routes"

	_ "github.com/lib/pq"
)

func main() {
	connStr := "user=postgres dbname=yourdbname sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	r := routes.SetupRouter(db)
	log.Fatal(http.ListenAndServe(":8080", r))
}
