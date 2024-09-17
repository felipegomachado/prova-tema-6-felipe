CREATE TABLE IF NOT EXISTS cursos (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    carga_horaria INT NOT NULL,
    data_inicio DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS disciplinas (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    curso_id INT REFERENCES cursos(id) ON DELETE CASCADE
);