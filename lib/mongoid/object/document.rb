module Mongoid
  module Object
    module Document
      # :reek:TooManyStatements
      def self.included(base) # rubocop:disable Metrics/MethodLength
        base.const_set(
          'Document', Class.new do
            def yield_object
              catch do |delete_symbol|
                self.object = object.tap do |obj|
                  yield obj.tap { |obj_| obj_.delete_symbol = delete_symbol }
                end
                return save
              end
              delete
            end
          end
        )
        base::Document.include Mongoid::Document
        base::Document.field :o, as: :object, type: Dynamic

        base.extend(ClassMethods)
      end

      def save
        self.class::Document.new(object: self).save
      end

      # :reek:Attribute
      attr_accessor :delete_symbol

      def delete
        throw @delete_symbol
      end

      module ClassMethods
        include Enumerable

        def each(&block)
          return enum_for(__callee__) unless block_given?
          self::Document.each { |document| document.yield_object(&block) }
        end

        def consume
          return enum_for(__callee__) unless block_given?
          each do |object|
            yield object
            object.delete
          end
        end
      end
    end
  end
end
