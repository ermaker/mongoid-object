module Mongoid
  module Object
    class Worker
      def self.inherited(subclass)
        subclass.include Mongoid::Object::Document
      end

      attr_accessor :period, :count, :todo

      def tick
        @count -= 1
        return unless @count.zero?
        @count = @period
        send(*@todo)
      end
    end
  end
end
