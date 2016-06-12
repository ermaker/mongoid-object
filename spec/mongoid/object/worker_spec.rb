module Mongoid
  module Object
    class Worker
      class DummyWorker < Worker
        def something(*)
        end
      end
    end
  end
end

RSpec.describe Mongoid::Object::Worker do
  describe described_class::DummyWorker do
    describe 'with normal count' do
      subject do
        described_class.new.tap do |subject|
          subject.count = 3
        end
      end

      specify do
        expect { subject.tick }.to change { subject.count }.by(-1)
      end
    end

    describe 'with special count' do
      subject do
        described_class.new.tap do |subject|
          subject.period = 10
          subject.count = 1
          subject.todo = [:something, 1, [{}], :a]
        end
      end

      specify do
        expect(subject).to receive(:something).with(1, [{}], :a)
        subject.tick
        expect(subject.count).to eq(10)
      end

      specify focus: true do
        subject.save
        expect_any_instance_of(described_class).to \
          receive(:something).with(1, [{}], :a)
        described_class.each(&:tick)
      end
    end
  end
end
