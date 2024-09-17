package handlers

import (
	"backend/database"
	"backend/models"
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
)

func CreateCurso(w http.ResponseWriter, r *http.Request) {
	var curso models.Curso
	_ = json.NewDecoder(r.Body).Decode(&curso)

	sqlStatement := `INSERT INTO cursos (nome, carga_horaria, data_inicio) VALUES ($1, $2, $3) RETURNING id`
	id := 0
	err := database.DB.QueryRow(sqlStatement, curso.Nome, curso.CargaHoraria, curso.DataInicio).Scan(&id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	curso.ID = id
	json.NewEncoder(w).Encode(curso)
}

func GetCursos(w http.ResponseWriter, r *http.Request) {
	rows, err := database.DB.Query("SELECT id, nome, carga_horaria, data_inicio FROM cursos")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var cursos []models.Curso

	for rows.Next() {
		var curso models.Curso
		err := rows.Scan(&curso.ID, &curso.Nome, &curso.CargaHoraria, &curso.DataInicio)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		cursos = append(cursos, curso)
	}

	json.NewEncoder(w).Encode(cursos)
}

func UpdateCurso(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	var curso models.Curso
	_ = json.NewDecoder(r.Body).Decode(&curso)

	sqlStatement := `UPDATE cursos SET nome=$1, carga_horaria=$2, data_inicio=$3 WHERE id=$4`
	_, err := database.DB.Exec(sqlStatement, curso.Nome, curso.CargaHoraria, curso.DataInicio, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(curso)
}

func DeleteCurso(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	sqlStatement := `DELETE FROM cursos WHERE id=$1`
	_, err := database.DB.Exec(sqlStatement, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(map[string]string{"message": "Curso deletado com sucesso!"})
}
