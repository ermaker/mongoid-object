RSpec.describe Mongoid::Object do
  it 'has a version number' do
    expect(Mongoid::Object::VERSION).not_to be nil
  end
end
