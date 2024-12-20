# README

Para este projeto você vai precisar de:
Ruby versão 3.3.3
Rails versão 7.2.2
Docker e docker compose

1. Primeiro clone o repositório 
git clone https://github.com/SPEP-TCC/spep.git

2. Navegue até a pasta do projeto, e então faça o build do conteiner da aplicação:
(sudo) docker compose up --build

3. Em seguida, dê start no contêiner:
(sudo) docker compose start

4. Entre no console dentro do conteiner:
(sudo) docker compose exec app bash

5. E então instale as dependencias e crie e popule o banco:
bundle install
rails db:create
rails db:migrate
rails db:seed
exit

6. Reinicie o conteiner:
(sudo) docker compose stop
(sudo) docker compose start




