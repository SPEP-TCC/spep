# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
Instituicao.find_or_create_by([
    { nome: "IFRO - CAMPUS CALAMA", duracao_aula: 50, tempos_aula: 16, inep: "11109807",
      endereco: "AVENIDA CALAMA, 4985 LOTE 994, QUADRA 169. FLODOALDO PONTES PINTO.", horario_inicio_aula: "7:30",
      horario_fim_aulas: "22:40" },
    { nome: "EEEFM ESTUDO E TRABALHO", duracao_aula: 50, tempos_aula: 10, inep: "11001046",
      endereco: "RUA ALEXANDRE GUIMARÃES, BAIRRO AREAL, Nº1340" }
])

Ambiente.find_or_create_by([
    { descricao: "Sala de aula 1", capacidade: 40, periculosidade: false, instituicao_id: 1 },
    { descricao: "Sala de aula 2", capacidade: 35, periculosidade: false, instituicao_id: 1 },
    { descricao: "Sala de aula 3", capacidade: 30, periculosidade: false, instituicao_id: 1 },
    { descricao: "Laboratório 1", capacidade: 20, periculosidade: true, instituicao_id: 1 },
    { descricao: "Laboratório 2", capacidade: 25, periculosidade: false, instituicao_id: 1 }
])

[ "MATUTINO", "VESPERTINO", "NOTURNO", "INTEGRAL" ].each do |turno_desc|
    Turno.find_or_create_by!(descricao: turno_desc)
end

[ "EDUCACAO BASICA", "ENSINO SUPERIOR" ].each do |nivel_desc|
    Nivel.find_or_create_by!(descricao: nivel_desc)
end

Etapa.find_or_create_by!([
    { id: 1, descricao: "EDUCACAO INFANTIL", nivel_id: 1 },
    { id: 2, descricao: "ENSINO FUNDAMENTAL", nivel_id: 1 },
    { id: 3, descricao: "ENSINO MEDIO", nivel_id: 1 },
    { id: 4, descricao: "GRADUACAO", nivel_id: 2 }
])

Area.find_or_create_by!([
    { id: 1,  descricao: "CIENCIAS AGRARIAS", etapa_id: 4 },
    { id: 2,  descricao: "CIENCIAS BIOLOGICAS", etapa_id: 4 },
    { id: 3,  descricao: "CIENCIAS EXATAS E DA TERRA", etapa_id: 4 },
    { id: 4,  descricao: "CIENCIAS SOCIAIS APLICADAS", etapa_id: 4 },
    { id: 5,  descricao: "CIENCIAS DA SAUDE", etapa_id: 4 },
    { id: 6,  descricao: "LINGUISTICA LETRAS E ARTES", etapa_id: 4 },
    { id: 7,  descricao: "ENGENHARIAS", etapa_id: 4 },
    { id: 8,  descricao: "MATEMATICA", etapa_id: 2 },
    { id: 9,  descricao: "CIENCIAS DA NATUREZA", etapa_id: 2 },
    { id: 10, descricao: "LINGUAGENS", etapa_id: 2 },
    { id: 11, descricao: "CIENCIAS HUMANAS", etapa_id: 2 },
    { id: 12, descricao: "MATEMATICA", etapa_id: 2 },
    { id: 13, descricao: "LINGUAGENS E SUAS TECNOLOGIAS", etapa_id: 3 },
    { id: 14, descricao: "MATEMATICA E SUAS TECNOLOGIAS", etapa_id: 3 },
    { id: 15, descricao: "CIENCIAS DA NATUREZA E SUAS TECNOLOGIAS", etapa_id: 3 },
    { id: 16, descricao: "CIENCIAS HUMANAS", etapa_id: 3 },
    { id: 17, descricao: "SOCIAIS APLICADAS", etapa_id: 3 }
])

Subarea.find_or_create_by!([
    { descricao: "ALGEBRA", area_id: 3 },
    { descricao: "ANALISE", area_id: 3 },
    { descricao: "GEOMETRIA E TOPOLOGIA", area_id: 3 },
    { descricao: "MATEMATICA APLICADA", area_id: 3 },
    { descricao: "PROBABILIDADE", area_id: 3 },
    { descricao: "ESTATISTICA", area_id: 3 },
    { descricao: "PROBABILIDADE E ESTATISTICA APLICADAS", area_id: 3 },
    { descricao: "TEORIA DA COMPUTACAO", area_id: 3 },
    { descricao: "MATEMATICA DA COMPUTACAO", area_id: 3 },
    { descricao: "METODOLOGIA E TECNICAS DA COMPUTACAO", area_id: 3 },
    { descricao: "SISTEMAS DE COMPUTACAO", area_id: 3 },
    { descricao: "ASTRONOMIA DE POSICAO E MECANICA CELESTE", area_id: 3 },
    { descricao: "ASTROFISICA ESTELAR", area_id: 3 },
    { descricao: "ASTROFISICA DO MEIO INTERESTELAR", area_id: 3 },
    { descricao: "ASTROFISICA EXTRAGALATICA", area_id: 3 }
])

TipoContrato.find_or_create_by!([
    { descricao: "EFETIVO", carga_horaria: 30 },
    { descricao: "TEMPORARIO", carga_horaria: 30 },
    { descricao: "EFETIVO", carga_horaria: 40 }
])

[ "PRESENCIAL", "EAD", "SEMIPRESENCIAL" ].each do |met_desc|
    Metodologia.find_or_create_by!(descricao: met_desc)
end

[ "EJA", "ESPECIAL", "REGULAR", "TECNICO CONCOMITANTE", "TECNICO SUBSEQUENTE", "TECNICO INTEGRADO",
"LICENCIATURA", "BACHARELADO", "TECNOLOGO" ].each do |modalidade_desc|
    Modalidade.find_or_create_by!(descricao: modalidade_desc)
end

CurriculoEmenta.find_or_create_by!([
    { descricao: "RESOLUÇÃO N° 62/CONSUP/IFRO", ano_documento: 2015 }
])

Disciplina.find_or_create_by([
    { descricao: "MATEMATICA",  subarea_id: 1 },
    { descricao: "MATEMATICA",  area_id: 3 },
    { descricao: "LINGUA PORTUGUESA",  area_id: 2 },
    { descricao: "LINGUA PORTUGUESA",  area_id: 3 },
    { descricao: "LINGUA INGLESA",  area_id: 2 },
    { descricao: "LINGUA INGLESA",  area_id: 3 },
    { descricao: "MATEMATICA",  area_id: 2 },
    { descricao: "BANCOS DE DADOS",  subarea_id: 10 },
    { descricao: "ESTRUTURAS DE DADOS",  subarea_id: 10 },
    { descricao: "ALGORITMOS",  subarea_id: 3 },
    { descricao: "ENGENHARIA DE SOFTWARE",  subarea_id: 8 }
])
Curso.find_or_create_by([
    { descricao: "ANALISE E DESENVOLVIMENTO DE SISTEMAS", etapa_id: 4, curriculo_ementa_id: 1,
    modalidade_id: 9, instituicao_id: 1 }
])

MatrizCurricularAplicada.find_or_create_by([
    { descricao: "MATRIZ CURRICULAR IFRO ADS 2022", ano_letivo: 2022,
    turno_id: 3, curso_id: 1, ativo: true }
])

GradeCurricular.find_or_create_by([
    { disciplina_id: 8, carga_horaria: 10, periodo_calendario: 1, optativa: false,
    carga_horaria_total: 56, matriz_curricular_aplicada_id: 1, ambiente_id: 1 },
    { disciplina_id: 9, carga_horaria: 15, periodo_calendario: 1, optativa: false,
    carga_horaria_total: 56, matriz_curricular_aplicada_id: 1, ambiente_id: 1 },
    { disciplina_id: 10, carga_horaria: 10, periodo_calendario: 1, optativa: false,
    carga_horaria_total: 40, matriz_curricular_aplicada_id: 1, ambiente_id: 2 },
    { disciplina_id: 11, carga_horaria: 6, periodo_calendario: 1, optativa: false,
    carga_horaria_total: 25, matriz_curricular_aplicada_id: 1, ambiente_id: 2 }
])
