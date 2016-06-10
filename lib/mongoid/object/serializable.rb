module Mongoid
  module Object
    module Serializable
      include Mongoid::Attributes::Dynamic
    end
  end
end
