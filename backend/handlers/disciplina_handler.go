package handlers

import (
	"backend/database"
	"backend/models"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func CreateDisciplina(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	cursoID, err := strconv.Atoi(vars["cursoID"])
	if err != nil {
		http.Error(w, "ID de curso inválido", http.StatusBadRequest)
		return
	}

	var disciplina models.Disciplina
	_ = json.NewDecoder(r.Body).Decode(&disciplina)
	disciplina.CursoID = cursoID

	sqlStatement := `INSERT INTO disciplinas (nome, curso_id) VALUES ($1, $2) RETURNING id`
	id := 0
	err = database.DB.QueryRow(sqlStatement, disciplina.Nome, disciplina.CursoID).Scan(&id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	disciplina.ID = id
	json.NewEncoder(w).Encode(disciplina)
}

func GetDisciplinasByCurso(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	cursoID, err := strconv.Atoi(vars["cursoID"])
	if err != nil {
		http.Error(w, "ID de curso inválido", http.StatusBadRequest)
		return
	}

	rows, err := database.DB.Query("SELECT id, nome FROM disciplinas WHERE curso_id = $1", cursoID)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var disciplinas []models.Disciplina

	for rows.Next() {
		var disciplina models.Disciplina
		err := rows.Scan(&disciplina.ID, &disciplina.Nome)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		disciplinas = append(disciplinas, disciplina)
	}

	json.NewEncoder(w).Encode(disciplinas)
}

func UpdateDisciplina(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	var disciplina models.Disciplina
	_ = json.NewDecoder(r.Body).Decode(&disciplina)

	sqlStatement := `UPDATE disciplinas SET nome=$1 WHERE id=$2`
	_, err := database.DB.Exec(sqlStatement, disciplina.Nome, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(disciplina)
}

func DeleteDisciplina(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	sqlStatement := `DELETE FROM disciplinas WHERE id=$1`
	_, err := database.DB.Exec(sqlStatement, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(map[string]string{"message": "Disciplina deletada com sucesso!"})
}
