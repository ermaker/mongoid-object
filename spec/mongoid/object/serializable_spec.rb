require 'mongoid'
require 'ostruct'

module Mongoid
  module Object
    class DummyClass < OpenStruct
      include Mongoid::Object::Serializable
    end
  end
end

RSpec.describe Mongoid::Object::Serializable do
  specify { expect(Mongoid::Object::DummyClass).to include(described_class) }

  describe Mongoid::Object::DummyClass do
    describe described_class::Document do
      specify { expect(described_class).to include(Mongoid::Document) }
      specify do
        subject.save
        expect(described_class.all.first.attributes).to eq(subject.attributes)
      end
    end

    specify do
      subject.x = 1
      subject.y = 2
      subject.save
      actual = described_class::Document.first.object
      expect(actual.x).to eq(1)
      expect(actual.y).to eq(2)
    end
  end
end
