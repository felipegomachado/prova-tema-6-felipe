package handlers

import (
	"database/sql"
	"encoding/json"
	"go-crud/models"
	"net/http"
)

func GetDisciplinas(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		rows, err := db.Query("SELECT id, nome FROM disciplinas")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var disciplinas []models.Disciplina
		for rows.Next() {
			var disciplina models.Disciplina
			if err := rows.Scan(&disciplina.ID, &disciplina.Nome); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			disciplinas = append(disciplinas, disciplina)
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(disciplinas)
	}
}
