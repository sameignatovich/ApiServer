FROM ruby:3.1.2-alpine

WORKDIR /app
COPY . ./

RUN apk add --no-cache  \
    make  \
    gcc  \
    libc-dev  \
    tzdata  \
    imagemagick  \
    imagemagick-dev  \
    imagemagick-libs  \
    vips \
    libpq-dev
RUN bundle config set --global deployment true \
    && bundle config set --global without development:test  \
    && bundle install

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
