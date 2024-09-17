package models

type Disciplina struct {
	ID      int    `json:"id"`
	Nome    string `json:"nome"`
	CursoID int    `json:"curso_id"`
}
