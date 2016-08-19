# CryptoWars

## Development

Start up dependencies:

```bash
docker-compose up -d
```

Install dependencies:

```bash
gem install bundler
bundle install
```

Set up database:

```bash
bundle exec rake db:create db:migrate
```

Seed it up with all the assets and a test fund:

```bash
bundle exec rake db:seed
```

Start it up:

```bash
bundle exec foreman start
open http://localhost:5000
```

### Resetting DB

```bash
bundle exec rake db:drop db:create db:migrate db:seed
```
