require './spec/spec_helper'

describe Rack::Routing::Router do
  let( :router ){ Rack::Routing::Router.for( env )}

  describe 'returns not_found' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET'       ,
                  'PATH_INFO' => '/no/such/path' }}

    specify do
      expect( router[ :method ]).to eq :not_found
      expect( router[ :params ]).to eq  Hash.new
    end
  end

  describe 'only matches GET, POST, PUT and DELETE' do
    context 'when FOO' do
      let( :env ){{ 'REQUEST_METHOD' => 'FOO'  ,
                    'PATH_INFO' => '/my/success' }}
      specify do
        expect{ router }.to raise_error 'Invalid HTTP method'
      end
    end
  end

  describe 'GET /apps' do
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

  describe 'GET /' do
    let( :env ){{ 'REQUEST_METHOD' => 'GET' ,
                  'PATH_INFO'      => '/'  }}

    specify do
      expect( router[ :method ]).to eq :get_root
      expect( router[ :params ]).to eq Hash.new
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
    let( :non_blank_lines ){ lines.count - blank_lines.count }

    specify do
      expect( Rack::Routing::Router.load_routes.count ).to eq non_blank_lines
    end
  end
end