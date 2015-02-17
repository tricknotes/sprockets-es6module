require 'minitest/autorun'
require 'minitest/power_assert'

require 'sprockets/es6module'

class TestSprocketsES6Module < MiniTest::Test
  def setup
    @env = Sprockets::Environment.new
    @env.append_path File.expand_path("../fixtures", __FILE__)
  end

  def test_export
    asset = @env['export.js']

    assert asset
    assert { 'application/javascript' == asset.content_type }

    expected = <<-JS.strip
define('export', function () {

\t'use strict';

\treturn "hello";

});
    JS

    assert { expected == asset.to_s }
  end

  def test_import
    asset = @env['import.js']

    assert asset
    assert { 'application/javascript' == asset.content_type }

    expected = <<-JS.strip
define('import', ['hi'], function (Hi) {

\t'use strict';

});
    JS

    assert { expected == asset.to_s }
  end

  def test_export_with_template
    asset = @env['export_with_template.js']

    assert asset
    assert { 'application/javascript' == asset.content_type }

    expected = <<-JS.strip
define('export_with_template', function () {

  'use strict';

  return function (name) {
    return "Hi, " + name + "!";
  };;

});
    JS

    assert { expected == asset.to_s }
  end

  def test_export_with_directory
    asset = @env['some-directory/hi.js']

    assert asset
    assert { 'application/javascript' == asset.content_type }

    expected = <<-JS.strip
define('some-directory/hi', function () {

\t'use strict';

\treturn "hi";

});
    JS

    assert { expected == asset.to_s }
  end
end
