class Route
  def initialize path
    @my_parts = path.split( '/' ).reject{| p | blank?( p )}.map( &:strip )
  end

  def match? parts
    return false unless parts.count == @my_parts.count
    
    indexes = ( 0..@my_parts.count - 1 ).to_a
    indexes.delete param_index

    indexes.all? do |i|
      parts[ i ].to_s == @my_parts[ i ]
    end
  end

  def params_for parts
    return {} unless param_index

    { @my_parts[ param_index ].sub( /\A:/, '' ).to_sym => parts[ param_index ]}
  end

  def routing_method
    return "#{ @my_parts[ 0 ].downcase }_root".to_sym if @my_parts.count == 1

    @my_parts.reject{ |p| p[ 0 ] == ':' }.map( &:downcase ).join( '_' ).to_sym
  end

  def param_index
    @my_parts.index{ |p| p[ 0 ] == ':' }
  end

  def to_s
    "#{ self.class } @my_parts:#{ @my_parts } count:#{ @my_parts.count }"
  end
end
