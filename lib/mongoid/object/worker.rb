module Mongoid
  module Object
    class Worker
      def self.inherited(subclass)
        subclass.include Mongoid::Object::Document
      end

      attr_accessor :period, :count, :todo

      def save_next(*next_todo)
        dup.tap { |worker| worker.todo = next_todo }.save
      end

      def tick
        @count -= 1
        return unless @count.zero?
        @count = @period
        send(*@todo)
      end

      # :nocov:
      def loop_tick
        loop do
          SLEEP 1
          tick
        end
      end
      # :nocov:
    end
  end
end
