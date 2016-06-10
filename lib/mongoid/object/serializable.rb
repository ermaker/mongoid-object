module Mongoid
  module Object
    module Serializable
      def self.included(base)
        base.const_set('Document', Class.new)
        base::Document.include Mongoid::Document
        base::Document.field :object, type: Dynamic
      end

      def save
        document = self.class::Document.new
        document.object = self
        document.save
      end
    end
  end
end
