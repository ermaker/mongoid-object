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
        self.class::Document.new.tap { |doc| doc.object = self }.save
      end

      attr_reader :delete

      def mark_delete
        @delete = true
      end

      module ClassMethods
        include Enumerable

        def each
          return enum_for(__callee__) unless block_given?
          self::Document.each do |document|
            document.object = document.object.tap { |object| yield object }
            next document.delete if document.object.delete
            document.save
          end
        end

        def consume
          return enum_for(__callee__) unless block_given?
          each { |object| yield object.tap(&:mark_delete) }
        end
      end
    end
  end
end
