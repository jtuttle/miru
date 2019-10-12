require "spec_helper"

RSpec.describe Miru::EventDispatcher do
  let(:observer) { Observer.new }
  let(:dispatcher) { Dispatcher.new }
  
  describe "adding an event listener" do
    it "raises error if the method is already registered for the given event" do
      expect {
        dispatcher.add_event_listener(:test, observer.method(:on_test))
        dispatcher.add_event_listener(:test, observer.method(:on_test))
      }.to raise_error(StandardError)
    end
  end

  describe "removing an event listener" do
    it "previously registered method is not called if listener is removed" do
      dispatcher.add_event_listener(:test, observer.method(:on_test))
      dispatcher.remove_event_listener(:test, observer.method(:on_test))
      dispatcher.dispatch
      
      expect(observer.count).to eq(0)
    end

    it "raises error if the method is not registered for the given event" do
      expect {
        dispatcher.remove_event_listener(:test, observer.method(:on_test))
      }.to raise_error(StandardError)
    end
  end

  describe "dispatching an event" do
    it "the registered method is called when the matching event is dispatched" do
      dispatcher.add_event_listener(:test, observer.method(:on_test))
      dispatcher.dispatch
      
      expect(observer.count).to eq(1)
    end
  end
end
