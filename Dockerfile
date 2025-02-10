FROM ruby:3.3.3

# Configurações iniciais
WORKDIR /app

# Dependências básicas
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libpq-dev \
    nodejs \
    npm && \
    rm -rf /var/lib/apt/lists/*

# Instalar Yarn
RUN npm install -g yarn

# Copiar apenas o Gemfile para instalar dependências
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN bundle install

# Copiar código da aplicação (para permitir cache das gems acima)
COPY . .

# Instalar dependências JS
RUN yarn install

# Remover PID antigo e iniciar o servidor
CMD ["sh", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0 -e $RAILS_ENV"]
