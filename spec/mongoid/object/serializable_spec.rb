require 'mongoid'
require 'ostruct'

module Mongoid
  module Object
    module Serializable
      class DummyClass < OpenStruct
        include Mongoid::Object::Serializable
      end
    end
  end
end

RSpec.describe Mongoid::Object::Serializable do
  specify { expect(described_class::DummyClass).to include(described_class) }

  describe described_class::DummyClass do
    describe described_class::Document do
      specify { expect(described_class).to include(Mongoid::Document) }
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
