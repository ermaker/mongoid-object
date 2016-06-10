require 'mongoid'

class DummyObject
  include Mongoid::Object::Serializable
end
RSpec.describe Mongoid::Object::Serializable do
  specify { expect(DummyObject).to include(described_class) }

  describe DummyObject do
    describe described_class::Document do
      specify { expect(described_class).to include(Mongoid::Document) }
      specify do
        expect(described_class).to include(Mongoid::Attributes::Dynamic)
      end
      specify do
        subject.save
        expect(described_class.all.first.attributes).to eq(subject.attributes)
      end
    end
  end
end
