require './spec/spec_helper'

describe Rack::Routing::Router do
  let( :router ){ Rack::Routing::Router.for env }

  describe 'returns not_found' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET'       ,
                  'PATH_INFO' => '/no/such/path' }}

    specify do
      expect( router[ :method ]).to eq :not_found
      expect( router[ :params ]).to eq  Hash.new
    end
  end

  describe 'only matches GET, POST, PUT, DELETE, OPTIONS' do
    let( :env ){{ 'PATH_INFO' => '/path' }}
    
    specify 'GET' do
      env.merge!( 'REQUEST_METHOD' => 'GET' )

      expect( router[ :method ]).to eq :get_path
    end

    specify 'POST' do
      env.merge!( 'REQUEST_METHOD' => 'POST' )
      
      expect( router[ :method ]).to eq :post_path
    end

    specify 'PUT' do
      env.merge!( 'REQUEST_METHOD' => 'PUT' )
      
      expect( router[ :method ]).to eq :put_path
    end

    specify 'DELETE' do
      env.merge!( 'REQUEST_METHOD' => 'DELETE' )
      
      expect( router[ :method ]).to eq :delete_path
    end

    specify 'OPTIONS' do
      env.merge!( 'REQUEST_METHOD' => 'OPTIONS' )
      
      expect( router[ :method ]).to eq :options_path
    end

    specify 'HEAD routes to GET' do
      env.merge!( 'REQUEST_METHOD' => 'HEAD' )
      
      expect( router[ :method ]).to eq :get_path
    end
  end

  describe 'does not match invalid method' do
    let( :env ){{ 'REQUEST_METHOD' => 'FOO'       ,
                  'PATH_INFO' => '/no/such/path' }}
    specify do
      expect{ router }.to raise_error 'Invalid HTTP method'
    end
  end

  describe 'GET /' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET' ,
                  'PATH_INFO'      => '/'  }}

    specify do
      expect( router[ :method ]).to eq :get_root
      expect( router[ :params ]).to eq Hash.new
    end
  end

  describe 'GET /app/:id/show' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET'   ,
                  'PATH_INFO' => '/app/123/show' }}

    specify do
      expect( router[ :method ]).to eq :get_app_show
      expect( router[ :params ][ :id ]).to eq '123'
    end
  end

  describe 'GET /app/:id/edit' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET'   ,
                  'PATH_INFO' => '/app/123/edit' }}

    specify do
      expect( router[ :method ]).to eq :get_app_edit
      expect( router[ :params ][ :id ]).to eq '123'
    end
  end

  describe 'GET /js/:file' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET'   ,
                  'PATH_INFO' => '/js/jquery.js' }}

    specify do
      expect( router[ :method ]).to eq :get_js
      expect( router[ :params ][ :file ]).to eq 'jquery.js'
    end
  end

  describe 'GET /url-with-dashes/:value converts to underbars in method name' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET'   ,
                  'PATH_INFO'      => '/url-with-dashes/123' }}

    specify do
      expect( router[ :method ]).to eq :get_url_with_dashes
      expect( router[ :params ][ :value ]).to eq '123'
    end
  end

  describe 'POST with two params: /apps/mac/names/sublime' do
    let( :env ){{ 'REQUEST_METHOD' => 'POST',
                  'PATH_INFO'      => '/apps/mac/names/sublime' }}

    specify do
      expect( router[ :method ]).to eq :post_apps_names
      expect( router[ :params ][ :computer ]).to eq 'mac'
      expect( router[ :params ][ :software ]).to eq 'sublime'
    end
  end

  describe 'only matches correct HTTP method' do
    context 'when GET instead of POST' do
      let( :env ){{ 'REQUEST_METHOD' => 'GET'  ,
                    'PATH_INFO' => '/create/commit' }}
      specify do
        expect( router[ :method ]).to eq :not_found
        expect( router[ :params ]).to eq  Hash.new
      end
    end
  end

  describe 'skip blank lines in routes.txt' do
    let( :lines ){ File.read( ROUTES_FILE ).split( "\n" )}
    let( :blank_lines ){ lines.select{| l | Rack::Routing::String.blank?( l )}}
    let( :comment_lines ){ lines.select{| l | l.match /\A\s*#/ }}
    let( :non_blank_lines ){ lines.count - blank_lines.count - comment_lines.count }

    specify do
      expect( Rack::Routing::Router.load_routes.count ).to eq non_blank_lines
    end
  end

  describe 'skip # comment lines in routes.txt' do
    let( :lines ){ File.read( ROUTES_FILE ).split( "\n" )}
    let( :blank_lines ){ lines.select{| l | Rack::Routing::String.blank?( l )}}
    let( :comment_lines ){ lines.select{| l | l.match /\A\s*#/ }}
    let( :valid_lines ){ lines.count - blank_lines.count - comment_lines.count }

    specify do
      expect( Rack::Routing::Router.load_routes.count ).to eq valid_lines
    end
  end
end
