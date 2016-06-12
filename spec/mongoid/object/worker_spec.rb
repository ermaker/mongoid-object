module Mongoid
  module Object
    class Worker
      class DummyWorker < Worker
        def something(*)
        end

        def delete_and_something(*)
          delete
          this_statement_should_not_be_executed
        end

        def add_another_and_delete(*)
          todo[1] += 1
          save
          delete
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

      specify do
        subject.save
        expect_any_instance_of(described_class).to \
          receive(:something).with(1, [{}], :a)
        described_class.each(&:tick)
      end
    end

    describe 'with delete itself' do
      subject do
        described_class.new.tap do |subject|
          subject.period = 10
          subject.count = 1
          subject.todo = :delete
        end
      end

      specify do
        subject.save
        expect { described_class.each(&:tick) }.to \
          change { described_class::Document.all.size }.by(-1)
      end
    end

    describe 'with delete' do
      subject do
        described_class.new.tap do |subject|
          subject.period = 10
          subject.count = 1
          subject.todo = :delete_and_something
        end
      end

      specify do
        subject.save
        expect { described_class.each(&:tick) }.to \
          change { described_class::Document.all.size }.by(-1)
      end
    end

    describe 'with add another' do
      subject do
        described_class.new.tap do |subject|
          subject.period = 2
          subject.count = 1
          subject.todo = [:add_another_and_delete, 0]
        end
      end

      before { subject.save }

      specify do
        expect do
          10.times { described_class.each(&:tick) }
        end.not_to change { described_class::Document.all.size }
      end

      specify do
        5.times do
          expect do
            2.times { described_class.each(&:tick) }
          end.to change { described_class.first.todo[1] }.by(1)
        end
      end
    end
  end
end
