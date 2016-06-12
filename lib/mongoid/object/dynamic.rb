require 'oj'
require 'json'

module Mongoid
  module Object
    class Dynamic
      class << self
        def demongoize(object)
          Oj.load(JSON.dump(object))
        end

        def mongoize(object)
          JSON.load(Oj.dump(object))
        end
      end
    end
  end
end
