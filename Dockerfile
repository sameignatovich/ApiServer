FROM ruby:3.1.2
RUN apt-get update -qq
RUN apt-get install -y libpq-dev libvips42
RUN apt-get clean
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle config set --global deployment true
RUN bundle config set --global without development:test
RUN bundle install
COPY . ./

ENV RAILS_ENV="production"

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
