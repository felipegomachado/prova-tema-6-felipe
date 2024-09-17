package routes

import (
	"database/sql"
	"go-crud/handlers"

	"github.com/gorilla/mux"
)

func SetupRouter(db *sql.DB) *mux.Router {
	r := mux.NewRouter()

	r.HandleFunc("/cursos", handlers.GetCursos(db)).Methods("GET")

	r.HandleFunc("/disciplinas", handlers.GetDisciplinas(db)).Methods("GET")

	return r
}
