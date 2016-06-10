module Mongoid
  module Object
    module Serializable
      def self.included(base)
        base.const_set(
          'Document',
          Class.new do
            include Mongoid::Document
            include Mongoid::Attributes::Dynamic
          end
        )
      end
    end
  end
end
