json.extract! instituicao, :id, :nome, :inep, :endereco, :duracao_aula, :horario_inicio_aula, :horario_fim_aulas, :tempos_aula, :created_at, :updated_at
json.url instituicao_url(instituicao, format: :json)
