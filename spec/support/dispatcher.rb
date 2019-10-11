class Dispatcher
  include Miru::EventDispatcher

  def dispatch
    dispatch_event(:test)
  end
end
