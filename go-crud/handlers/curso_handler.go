package handlers

import (
	"database/sql"
	"encoding/json"
	"go-crud/models"
	"net/http"
)

func GetCursos(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		rows, err := db.Query("SELECT id, nome, carga_horaria, data_inicio FROM cursos")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var cursos []models.Curso
		for rows.Next() {
			var curso models.Curso
			if err := rows.Scan(&curso.ID, &curso.Nome, &curso.CargaHoraria, &curso.DataInicio); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			cursos = append(cursos, curso)
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(cursos)
	}
}
