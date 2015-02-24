describe Route do
  describe '#match?' do
    describe 'success' do
      let( :route ){   Route.new( 'GET /foo/bar' )}
      let( :parts ){[ 'GET', 'foo', 'bar' ]}

      specify do
        expect( route.match? parts ).to eq true
      end
    end

    context 'when method is a symbol' do
      let( :route ){   Route.new( 'GET /foo/bar' )}
      let( :parts ){[ :GET, 'foo', 'bar' ]}

      specify do
        expect( route.match? parts ).to eq true
      end
    end

    context 'when param in middle'  do
      let( :route ){   Route.new( 'GET /foo/:id/bar' )}
      let( :parts ){[ 'GET', 'foo', '123', 'bar' ]}

      specify do
        expect( route.match? parts ).to eq true
      end
    end

    context 'when param at the end' do
      let( :route ){   Route.new( 'GET /foo/bar/:id' )}
      let( :parts ){[ 'GET', 'foo', 'bar', '123' ]}

      specify do
        expect( route.match? parts ).to eq true
      end
    end

    context 'when method does not match' do
      let( :route ){   Route.new( 'GET /foo/bar/:id' )}
      let( :parts ){[ 'POST', 'foo', 'bar', '123' ]}

      specify do
        expect( route.match? parts ).to eq false
      end 
    end

    context 'when parts do not match' do
      let( :route ){   Route.new( 'GET /foo/bar/:id' )}
      let( :parts ){[ 'GET', 'foo', 'qux', '123' ]}

      specify do
        expect( route.match? parts ).to eq false
      end
    end
  end
end