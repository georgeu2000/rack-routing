class Router
  VALID_HTTP_METHODS = [ :GET, :POST, :PUT, :DELETE ]

  class << self
    def for env
      http_method = env[ 'REQUEST_METHOD' ].to_sym

      raise 'Invalid HTTP method' unless VALID_HTTP_METHODS.include?( http_method )

      parts = [ http_method ] + env[ 'PATH_INFO' ].split( '/' ).reject{| p | blank?( p )}

      matched_route = ROUTES.find do |route|
        route.match?( parts )
      end
  
      return { method: :not_found, params:{} } unless matched_route

      params = matched_route.params_for( parts )
  
      { method: matched_route.routing_method,
        params:params  }
    end

    def load_routes
      lines = File.read( ROUTES_FILE )
                  .split( "\n"      )
                  .reject{| l | blank?( l )}

      lines.map do |line|
        Route.new( line )
      end
    end
  end
end