# [Cobudget](https://cobudget.co/)

[![Build Status](https://travis-ci.org/cobudget/cobudget-api.svg?branch=master)](https://travis-ci.org/cobudget/cobudget-api)
[![Code Climate](https://codeclimate.com/github/cobudget/cobudget-api/badges/gpa.svg)](https://codeclimate.com/github/cobudget/cobudget-api)

A collaborative funding tool for crowds with purpose. [See how it works!](https://docs.google.com/presentation/d/1ZQYKxhHwKuQGmOMPpoE8Eo0XMuw1yn55Bjgsh6-D0eQ/present?slide=id.p)

The backend (api) and the frontend has been merged into this repository in March 2018, to create a single repository with both components.

[Hosting repo](https://github.com/cobudget/cobudget.co) - GitHub Pages

[Contribute to our reading list!](https://github.com/cobudget/reading-list)

## Contributing

A local development environment can be created by running: 

    docker-compose up -d && docker-compose run cobudget-api rake db:migrate

Then open http://localhost:9000/

## Testing

cp docker-compose.test.yml docker-compose.override.yml && \
docker-compose down && \
docker-compose build > /dev/null && \
docker-compose run cobudget-api ; \
rm -f docker-compose.override.yml

cp docker-compose.test.yml docker-compose.override.yml && \
docker-compose run cobudget-api ; \
rm -f docker-compose.override.yml



### Licensing

The materials in this repo are licensed under Creative Commons 1.0 Universal while the component apps are licensed separately under the Affero GPL.

## Previous repositories

The old repos still exist but should no longer be used.

[Old ui repo](https://github.com/cobudget/cobudget-ui) - Angular/Node front-end

[Old api repo](https://github.com/cobudget/cobudget-api) - Rails back-end



