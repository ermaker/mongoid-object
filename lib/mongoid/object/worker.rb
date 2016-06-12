module Mongoid
  module Object
    class Worker
      def self.inherited(subclass)
        subclass.include Mongoid::Object::Document
      end

      # :reek:Attribute
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
      def self.loop_tick
        loop do
          sleep 1
          each(&:tick)
        end
      end
      # :nocov:
    end
  end
end
