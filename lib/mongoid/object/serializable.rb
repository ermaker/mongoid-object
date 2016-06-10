module Mongoid
  module Object
    module Serializable
      def self.included(base)
        base.const_set('Document', Class.new)
        base::Document.include Mongoid::Document
        base::Document.include Mongoid::Attributes::Dynamic
      end
    end
  end
end
