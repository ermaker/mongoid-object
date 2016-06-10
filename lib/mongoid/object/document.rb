module Mongoid
  module Object
    module Document
      def self.included(base)
        base.const_set('Document', Class.new)
        base::Document.include Mongoid::Document
        base::Document.field :object, type: Dynamic

        base.extend(ClassMethods)
      end

      def save
        document = self.class::Document.new
        document.object = self
        document.save
      end

      module ClassMethods
        def consume
          return enum_for(:consume) unless block_given?
          self::Document.each do |document|
            yield document.object
            document.delete
          end
        end
      end
    end
  end
end
