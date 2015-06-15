## Rack Routing
----
Map URL routes to Ruby methods.

An example app is available at [Rack Routing Demo](https://github.com/iAmPlus/rack-routing-demo).

### Installation
Command line:  
`gem install rack-routing`

Or add to your Gemfile:  
`gem rack-routing`

Require the rack-routing file in an initializer:  
`require rack/routing`

### Example Routes

1. `GET /` => `get_root`
1. `GET /foos/:id` => `get_foos` (with `@url_params`)
1. `POST /foos` => `post_foos`

Create a `config/routes.txt` file to set up the routes.

### Example Requests

Request: `POST /foos/bar`  

routes.txt: `POST /foos/:value`

The `@url_params` is set to `{ value: 'bar' }`

The Ruby request handler might look like:   

    def post_foos
      Foo.create @url_params
      Rack::Response.new 'Foo was created.', 200
    end

---

Here is a second example request:

    `POST /foos, { "bar":"baz" }`  

Since this request uses body params, the `@params` is set to `{ baz: 'bar' }`

The Ruby request handler might look like:   

    def post_foos
      Foo.create @params
      Rack::Response.new 'Foo was created.', 200
    end

### To run specs
    rspec

or

    bundle exec guard