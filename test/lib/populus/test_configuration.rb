class TestConfiguration < Test::Unit::TestCase
  def teardown
    Populus.instance_eval { @_config = Configuration.new }
  end

  def test_default_value
    assert { Populus.config.class == Populus::Configuration }
  end

  def test_set_value
    Populus.config do
      set :foo, 123
      set :bar, "String"
      set :buz, -> { "Wrapped".upcase }
      set :fizz, -> { rand(65535) }
    end

    assert { Populus.config.foo == 123 }
    assert { Populus.config.bar == "String" }
    assert { Populus.config.buz == "WRAPPED" }

    assert("Access lambda again") { Populus.config.fizz == Populus.config.fizz }
  end

  def test_access_unset_value
    err = nil
    begin
      Populus.config.unknown
    rescue Exception => e
      err = e
    end

    assert { e.class == NameError }
    assert { e.message.include? "Configuration value unknown is not yet defined" }
  end
end
