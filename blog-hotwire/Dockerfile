FROM ruby:3.3.0
RUN apt-get update -qq && apt-get install -y --no-install-recommends apt-utils nodejs lsb-release npm
RUN npm install --global yarn
RUN apt-get -y install bash-completion wget
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |tee  /etc/apt/sources.list.d/pgdg.list
RUN apt-get update -qq && apt-get install -y postgresql-16 postgresql-client-16
RUN mkdir -p /app/blog-hotwire
WORKDIR /app/blog-hotwire
COPY Gemfile /app/blog-hotwire/Gemfile
COPY Gemfile.lock /app/blog-hotwire/Gemfile.lock
RUN bundle install
COPY . /app/blog-hotwire

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
