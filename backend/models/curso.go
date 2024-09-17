package models

type Curso struct {
	ID           int      `json:"id"`
	Nome         string   `json:"nome"`
	CargaHoraria int      `json:"cargaHoraria"`
	DataInicio   string   `json:"dataInicio"`
	Disciplinas  []string `json:"disciplinas,omitempty"`
}
