class TestPopulus < Test::Unit::TestCase
  def test_logger_accessible
    l = Logger.new(open('/dev/null'))
    Populus.logger = l
    assert { Populus.logger == l }
  end

end
