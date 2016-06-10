require 'mongoid'

class DummyObject
  include Mongoid::Document
  include Mongoid::Object::Serializable
end
RSpec.describe Mongoid::Object::Serializable do
  specify { expect(DummyObject).to include(described_class) }
  describe DummyObject do
    it { is_expected.to include(Mongoid::Document) }
  end
end
