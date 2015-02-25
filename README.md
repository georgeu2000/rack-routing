## Rack Routing
----
This gem maps URL routes to Ruby methods.

### Installation
Command line:  
`gem install rack-routing`

Or add to your Gemfile:  
`gem rack-routing`

### Example Routes

1. `GET /` => `get_root`
1. `GET /foos/:id` => `get_foo` (with `@url_params`)
1. `POST /foos` => `post_foos`

Create a `config/routes.txt` file to set up the routes.

### Example Request

Request: `POST /foos, { "bar":"baz" }`  
Ruby:   

    def post_foos
      Foo.create @params
      Rack::Response.new( 'Foo was created', 200 )
    end

An example app is available at [Rack Routing Demo](https://github.com/iAmPlus/rack-routing-demo).

### To run specs
    rspec

or

    guard