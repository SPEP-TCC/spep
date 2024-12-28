# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_28_213632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambientes", force: :cascade do |t|
    t.string "descricao"
    t.integer "capacidade"
    t.boolean "periculosidade"
    t.bigint "instituicao_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instituicao_id"], name: "index_ambientes_on_instituicao_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "descricao"
    t.bigint "etapa_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etapa_id"], name: "index_areas_on_etapa_id"
  end

  create_table "aulas", force: :cascade do |t|
    t.bigint "grade_curricular_id", null: false
    t.bigint "ambiente_id", null: false
    t.integer "dia"
    t.time "horario_inicio"
    t.time "horario_fim"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ambiente_id"], name: "index_aulas_on_ambiente_id"
    t.index ["grade_curricular_id"], name: "index_aulas_on_grade_curricular_id"
  end

  create_table "curriculo_ementa_disciplinas", force: :cascade do |t|
    t.bigint "curriculo_ementa_id", null: false
    t.bigint "disciplina_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curriculo_ementa_id"], name: "index_curriculo_ementa_disciplinas_on_curriculo_ementa_id"
    t.index ["disciplina_id"], name: "index_curriculo_ementa_disciplinas_on_disciplina_id"
  end

  create_table "curriculos_ementas", force: :cascade do |t|
    t.string "descricao"
    t.integer "ano_documento"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cursos", force: :cascade do |t|
    t.string "descricao"
    t.bigint "etapa_id", null: false
    t.bigint "curriculo_ementa_id", null: false
    t.bigint "instituicao_id", null: false
    t.bigint "modalidade_id", null: false
    t.bigint "metodologia_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curriculo_ementa_id"], name: "index_cursos_on_curriculo_ementa_id"
    t.index ["etapa_id"], name: "index_cursos_on_etapa_id"
    t.index ["instituicao_id"], name: "index_cursos_on_instituicao_id"
    t.index ["metodologia_id"], name: "index_cursos_on_metodologia_id"
    t.index ["modalidade_id"], name: "index_cursos_on_modalidade_id"
  end

  create_table "disciplinas", force: :cascade do |t|
    t.string "descricao"
    t.string "codigo"
    t.bigint "area_id"
    t.bigint "subarea_id"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_disciplinas_on_area_id"
    t.index ["subarea_id"], name: "index_disciplinas_on_subarea_id"
  end

  create_table "disponibilidade_salas", force: :cascade do |t|
    t.bigint "ambiente_id", null: false
    t.integer "dia"
    t.time "horario_inicio"
    t.time "horario_fim"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ambiente_id"], name: "index_disponibilidade_salas_on_ambiente_id"
  end

  create_table "etapas", force: :cascade do |t|
    t.string "descricao"
    t.bigint "nivel_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nivel_id"], name: "index_etapas_on_nivel_id"
  end

  create_table "grades_curriculares", force: :cascade do |t|
    t.bigint "disciplina_id", null: false
    t.integer "carga_horaria"
    t.integer "periodo_calendario"
    t.boolean "optativa"
    t.bigint "matriz_curricular_aplicada_id", null: false
    t.bigint "user_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disciplina_id"], name: "index_grades_curriculares_on_disciplina_id"
    t.index ["matriz_curricular_aplicada_id"], name: "index_grades_curriculares_on_matriz_curricular_aplicada_id"
    t.index ["user_id"], name: "index_grades_curriculares_on_user_id"
  end

  create_table "instituicoes", force: :cascade do |t|
    t.string "nome"
    t.integer "duracao_aula"
    t.integer "tempos_aula"
    t.string "cnpj"
    t.string "inep"
    t.string "endereco"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matrizes_curriculares_aplicadas", force: :cascade do |t|
    t.string "descricao"
    t.string "ano_letivo"
    t.bigint "turno_id", null: false
    t.bigint "curso_id", null: false
    t.boolean "ativo"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curso_id"], name: "index_matrizes_curriculares_aplicadas_on_curso_id"
    t.index ["turno_id"], name: "index_matrizes_curriculares_aplicadas_on_turno_id"
  end

  create_table "metodologias", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modalidades", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "niveis", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restricoes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "turno_id", null: false
    t.integer "dia"
    t.time "horario"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["turno_id"], name: "index_restricoes_on_turno_id"
    t.index ["user_id"], name: "index_restricoes_on_user_id"
  end

  create_table "subareas", force: :cascade do |t|
    t.string "descricao"
    t.bigint "area_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_subareas_on_area_id"
  end

  create_table "tipos_contratos", force: :cascade do |t|
    t.string "descricao"
    t.integer "carga_horaria_semanal"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turmas", force: :cascade do |t|
    t.string "descricao"
    t.integer "vagas"
    t.bigint "matriz_curricular_aplicada_id", null: false
    t.integer "numero_efetivo_estudantes"
    t.boolean "sala_recorrente"
    t.bigint "turno_id", null: false
    t.bigint "ambiente_id"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ambiente_id"], name: "index_turmas_on_ambiente_id"
    t.index ["matriz_curricular_aplicada_id"], name: "index_turmas_on_matriz_curricular_aplicada_id"
    t.index ["turno_id"], name: "index_turmas_on_turno_id"
  end

  create_table "turnos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "cpf"
    t.string "nome"
    t.boolean "admin"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ambientes", "instituicoes"
  add_foreign_key "areas", "etapas"
  add_foreign_key "aulas", "ambientes"
  add_foreign_key "aulas", "grades_curriculares"
  add_foreign_key "curriculo_ementa_disciplinas", "curriculos_ementas"
  add_foreign_key "curriculo_ementa_disciplinas", "disciplinas"
  add_foreign_key "cursos", "curriculos_ementas"
  add_foreign_key "cursos", "etapas"
  add_foreign_key "cursos", "instituicoes"
  add_foreign_key "cursos", "metodologias"
  add_foreign_key "cursos", "modalidades"
  add_foreign_key "disciplinas", "areas"
  add_foreign_key "disciplinas", "subareas"
  add_foreign_key "disponibilidade_salas", "ambientes"
  add_foreign_key "etapas", "niveis"
  add_foreign_key "grades_curriculares", "disciplinas"
  add_foreign_key "grades_curriculares", "matrizes_curriculares_aplicadas"
  add_foreign_key "grades_curriculares", "users"
  add_foreign_key "matrizes_curriculares_aplicadas", "cursos"
  add_foreign_key "matrizes_curriculares_aplicadas", "turnos"
  add_foreign_key "restricoes", "turnos"
  add_foreign_key "restricoes", "users"
  add_foreign_key "subareas", "areas"
  add_foreign_key "turmas", "ambientes"
  add_foreign_key "turmas", "matrizes_curriculares_aplicadas"
  add_foreign_key "turmas", "turnos"
end
