require 'mongoid'
require 'ostruct'

module Mongoid
  module Object
    class Dynamic
      class Point < OpenStruct
      end

      class DummyClass
        include Mongoid::Document
        field :object, type: Mongoid::Object::Dynamic
      end
    end
  end
end

RSpec.describe Mongoid::Object::Dynamic do
  describe described_class::DummyClass do
    specify do
      subject.object =
        { point: Mongoid::Object::Dynamic::Point.new.tap { |p| p.x = 1 } }
      subject.save
      expect(described_class.first.object).to be_a(Hash)
      expect(described_class.first.object[:point]).to \
        be_a(Mongoid::Object::Dynamic::Point)
      expect(described_class.first.object[:point].x).to eq(1)
    end
  end
end
