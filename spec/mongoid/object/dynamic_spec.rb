require 'mongoid'
require 'ostruct'

class Point < OpenStruct
end

class DummyObject
  include Mongoid::Document
  field :object, type: Mongoid::Object::Dynamic
end

RSpec.describe Mongoid::Object::Serializable do
  describe DummyObject do
    specify do
      subject.object = { point: Point.new.tap { |p| p.x = 1 } }
      subject.save
      expect(described_class.all.first.object).to be_a(Hash)
      expect(described_class.all.first.object[:point]).to be_a(Point)
      expect(described_class.all.first.object[:point].x).to eq(1)
    end
  end
end
