require 'mongoid'

class DummyObject
  include Mongoid::Document
  include Mongoid::Object::Serializable
end
RSpec.describe Mongoid::Object::Serializable do
  specify { expect(DummyObject).to include(described_class) }

  describe DummyObject do
    specify { expect(described_class).to include(Mongoid::Document) }
    specify { expect(described_class).to include(Mongoid::Attributes::Dynamic) }
  end
end
