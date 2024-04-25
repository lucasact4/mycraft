# Use a imagem oficial do Ruby como base
FROM ruby:3.1.4

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock para o diretório de trabalho
COPY Gemfile Gemfile.lock ./

# Instale as gemas
RUN bundle install

# Copie o restante do código-fonte para o diretório de trabalho
COPY . .

# Exponha a porta 3000
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]