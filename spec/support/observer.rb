class Observer
  attr_reader :count

  def initialize
    @count = 0
  end

  def on_test
    @count += 1
  end
end
