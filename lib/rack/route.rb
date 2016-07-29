module Rack
  module Routing
    class Route
      def initialize path
        @my_parts = path.split( '/' ).reject{| p | String.blank?( p )}.map( &:strip )
      end

      def match? parts
        return false unless parts.count == @my_parts.count

        # HEAD request matches #GET route
        if parts.first.to_s.upcase.to_sym == :HEAD
          parts[ 0 ] = :GET
        end
        
        indexes = ( 0..@my_parts.count - 1 ).to_a

        param_indexes.each{| i | indexes.delete i }

        indexes.all? do |i|
          parts[ i ].to_s == @my_parts[ i ]
        end
      end

      def params_for parts
        return {} unless param_indexes

        arr = param_indexes.map{| i | [ @my_parts[ i ].sub( /\A:/, '' ).to_sym, parts[ i ]]}
        
        arr.to_h
      end

      def routing_method
        return "#{ @my_parts[ 0 ].downcase }_root".to_sym if @my_parts.count == 1

        @my_parts.reject{ |p| p[ 0 ] == ':' }
                 .map( &:downcase )
                 .map{| p | p.gsub( '-', '_' )}
                 .join( '_' )
                 .to_sym
      end

      def param_indexes
        @my_parts.map.with_index{ | p,i | i if p[ 0 ] == ':' }.compact
      end

      def to_s
        "#{ self.class } @my_parts:#{ @my_parts } count:#{ @my_parts.count }"
      end
    end
  end
end