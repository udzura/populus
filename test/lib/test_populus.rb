class TestPopulus < Test::Unit::TestCase
  def test_logger_accessible
    l = Logger.new(open('/dev/null'))
    Populus.logger = l
    assert { Populus.logger == l }
  end

  def test_consul_bin_accessible
    assert("Havind default value") { Populus.consul_bin == "consul" }

    Populus.consul_bin = "/opt/consul/bin/consul"
    assert { Populus.consul_bin == "/opt/consul/bin/consul" }
  end

end
