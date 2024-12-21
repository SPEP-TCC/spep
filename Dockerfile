# Use official Ruby image
FROM ruby:3.3.3

# Install dependencies for Rails
RUN apt-get update -qq && apt-get install -y zsh nodejs postgresql-client

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

# Set working directory inside container
WORKDIR /app

# Copy Gemfile and Gemfile.lock to container
COPY Gemfile Gemfile.lock ./

# Install Rails dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Install Yarn packages
RUN yarn install

# Precompile assets for production (optional, you can remove for development)
#RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose Rails port
EXPOSE 3001

# Start the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]