json.extract! matriz_curricular_aplicada, :id, :descricao, :ano_letivo, :turno_id, :curso_id, :ativo, :created_at, :updated_at
json.url matriz_curricular_aplicada_url(matriz_curricular_aplicada, format: :json)
