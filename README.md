![Logo of the project](https://raw.githubusercontent.com/jehna/readme-best-practices/master/sample-logo.png)

# MarketPlaceAPI
> Additional information or tagline

## About the Project

Welcome to our Rails API project, developed using the latest techniques and best practices of Rails 7. This project serves as a solid foundation for the development of RESTful applications, incorporating modern programming standards and recommended guidelines.

## Features

Rails 7: We use the latest version of the Ruby on Rails framework to take advantage of the latest features and improvements.

Swagger Documentation: We implement Swagger for clear and interactive API documentation, making it easy to understand and collaborate.

## Installing / Getting started

Postgres 13

Requirements: Docker e Docker Compose ou Ruby 3.2.0

Without docker

```sh
$ bundle install
$ rails server
```


With docker 

```shell
$ docker-compose up -d
```

Access the link for the documentation of the endpoints. [Link API Doc](http://api.lvh.me:3000/api-docs/index.html)

API Link [Link API](http://api.lvh.me:3000)

## Developing

Here's a brief intro about what a developer must do in order to start developing
the project further:

```shell
git clone git@github.com:LeandroTrombini/marketplace_api.git
cd marketplace_api/
bundle install
```

Access the server.: http://localhost:3000


### Gereando Documentacão

Without docker

```shell
$ rake rswag:specs:swaggerize
```

With docker

```shell
$ docker-compose run app rake rswag:specs:swaggerize
```

### Deploying / Publishing

In case there's some step you have to take that publishes this project to a
server, this is the right time to state it.

```shell
packagemanager deploy awesome-project -s server.com -u username -p password
```

And again you'd need to tell what the previous code actually does.

## Features

What's all the bells and whistles this project can perform?
* What's the main functionality
* You can also do another thing
* If you get really randy, you can even do this

## Configuration

Here you should write what are all of the configurations a user can enter when
using the project.

#### Argument 1
Type: `String`  
Default: `'default value'`

State what an argument does and how you can use it. If needed, you can provide
an example below.

Example:
```bash
awesome-project "Some other value"  # Prints "You're nailing this readme!"
```

#### Argument 2
Type: `Number|Boolean`  
Default: 100

Copy-paste as many of these as you need.

## Contributing

When you publish something open source, one of the greatest motivations is that
anyone can just jump in and start contributing to your project.

These paragraphs are meant to welcome those kind souls to feel that they are
needed. You should state something like:

"If you'd like to contribute, please fork the repository and use a feature
branch. Pull requests are warmly welcome."

If there's anything else the developer needs to know (e.g. the code style
guide), you should link it here. If there's a lot of things to take into
consideration, it is common to separate this section to its own file called
`CONTRIBUTING.md` (or similar). If so, you should say that it exists here.

## Links

Even though this information can be found inside the project on machine-readable
format like in a .json file, it's good to include a summary of most useful
links to humans using your project. You can include links like:

- Project homepage: https://your.github.com/awesome-project/
- Repository: https://github.com/your/awesome-project/
- Issue tracker: https://github.com/your/awesome-project/issues
  - In case of sensitive bugs like security vulnerabilities, please contact
    my@email.com directly instead of using issue tracker. We value your effort
    to improve the security and privacy of this project!
- Related projects:
  - Your other project: https://github.com/your/other-project/
  - Someone else's project: https://github.com/someones/awesome-project/


## Licensing

One really important part: Give your project a proper license. Here you should
state what the license is and how to find the text version of the license.
Something like:

"The code in this project is licensed under MIT license."