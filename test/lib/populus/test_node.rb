class TestNode < Test::Unit::TestCase
  def setup
    Populus.config.set :ssh_options, {}
  end

  def teardown
    Populus::Node.instance_eval { @nodes = {} }
  end

  def test_set_node_via_hostname
    Populus::Node.register_host('xxx.example.com')

    assert { Populus::Node.registry.size == 1 }

    host = Populus::Node.registry['xxx.example.com']
    assert { host.is_a?(Specinfra::Backend::Ssh) }
    assert { host.get_config(:host) == 'xxx.example.com' }
  end
end
