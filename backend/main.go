package main

import (
	"backend/database"
	"backend/handlers"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func main() {
	// Conecta ao banco de dados
	database.Connect()

	// Cria um novo roteador
	router := mux.NewRouter()

	// Rotas para cursos
	router.HandleFunc("/cursos", handlers.CreateCurso).Methods("POST")
	router.HandleFunc("/cursos", handlers.GetCursos).Methods("GET")
	router.HandleFunc("/cursos/{id}", handlers.UpdateCurso).Methods("PUT")
	router.HandleFunc("/cursos/{id}", handlers.DeleteCurso).Methods("DELETE")

	// Rotas para disciplinas associadas a cursos
	router.HandleFunc("/cursos/{cursoID}/disciplinas", handlers.CreateDisciplina).Methods("POST")
	router.HandleFunc("/cursos/{cursoID}/disciplinas", handlers.GetDisciplinasByCurso).Methods("GET")
	router.HandleFunc("/disciplinas/{id}", handlers.UpdateDisciplina).Methods("PUT")
	router.HandleFunc("/disciplinas/{id}", handlers.DeleteDisciplina).Methods("DELETE")

	// Iniciar o servidor na porta 8080
	log.Println("Servidor iniciado na porta 8080")
	log.Fatal(http.ListenAndServe(":8080", router))
}
