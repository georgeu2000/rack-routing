module Rack
  module Routing
    class String
      def self.blank? str
        str.nil? || str == ''
      end
    end
  end
end