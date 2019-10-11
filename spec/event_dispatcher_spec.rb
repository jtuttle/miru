require "spec_helper"

RSpec.describe Miru::EventDispatcher do
  let(:observer) { Observer.new }
  let(:dispatcher) { Dispatcher.new }
  
  describe "adding an event listener" do
    it "dispatcher calls the registered method" do
      dispatcher.add_event_listener(:test, observer.method(:on_test))
      dispatcher.dispatch
      
      expect(observer.count).to eq(1)
    end

    it "raises an error if method is already registered" do
      expect {
        dispatcher.add_event_listener(:test, observer.method(:on_test))
        dispatcher.add_event_listener(:test, observer.method(:on_test))
      }.to raise_error(StandardError)
    end
  end

  describe "removing an event listener" do
    it "dispatcher does not call the previously registered method" do
      dispatcher.add_event_listener(:test, observer.method(:on_test))
      dispatcher.remove_event_listener(:test, observer.method(:on_test))
      dispatcher.dispatch
      
      expect(observer.count).to eq(0)
    end

    it "raises an error if no methods are registered" do
      expect {
        dispatcher.remove_event_listener(:test, observer.method(:on_test))
      }.to raise_error(StandardError)
    end
  end
end
