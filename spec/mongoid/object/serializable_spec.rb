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

    describe 'with variables' do
      before do
        subject.a = 1
        subject.b = :b
        subject.c = 'c'
        subject.d = [1, :b, 'c', [{}]]
        subject.e = { a: { b: [{}] } }
        subject.save
      end
      let(:actual) { described_class::Document.first.object }

      specify { expect(actual.a).to eq(1) }
      specify { expect(actual.b).to eq(:b) }
      specify { expect(actual.c).to eq('c') }
      specify { expect(actual.d).to eq([1, :b, 'c', [{}]]) }
      specify { expect(actual.e).to eq(a: { b: [{}] }) }
    end

    describe 'with objects' do
      let(:size) { 10 }
      before do
        size.times do |idx|
          described_class.new.tap { |obj| obj.value = idx }.save
        end
      end

      specify do
        expect do
          described_class.consume {}
        end.to change { described_class::Document.all.size }.by(-size)
      end

      specify do
        expect(described_class.consume.map(&:value)).to eq([*0..9])
      end

      specify do
        expect do
          described_class.consume(&:save)
        end.not_to change { described_class::Document.all.size }
      end
    end
  end
end
