package models

type Curso struct {
	ID           int    `json:"id"`
	Nome         string `json:"nome"`
	CargaHoraria int    `json:"carga_horaria"`
	DataInicio   string `json:"data_inicio"`
}
