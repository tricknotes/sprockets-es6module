require 'sprockets/es6module/version'

require 'esperanto'
require 'sprockets/es6'

module Sprockets
  class ES6Module
    MODULE_METHODS = {
      amd: 'toAmd',
      common: 'toCjs',
      umd: 'toUmd'
    }

    def self.instance
      @instance ||= new
    end

    def self.call(input)
      instance.call(input)
    end

    def initialize(type = :amd, options = {})
      @method = MODULE_METHODS[type]

      raise "Unsupported method `#{type}`. Available types are: #{MODULE_METHODS.keys.inspect}" unless @method

      @options = options.dup.freeze

      @cache_key = [
        self.class.name,
        Esperanto::VERSION,
        VERSION,
        @method
      ].freeze
    end

    def call(input)
      module_name = File.basename(input[:name], '.*')
      data = input[:data]
      options = @options.reverse_merge(amdName: module_name)
      result = input[:cache].fetch(@cache_key + [options, data]) do
        Esperanto.send(@method, data, options)
      end
      Sprockets::ES6.call(input.merge(data: result['code']))
    end
  end

  register_mime_type 'text/ecmascript-6+module', extensions: ['.es6module'], charset: :unicode
  register_transformer 'text/ecmascript-6+module', 'application/javascript', ES6Module
  register_preprocessor 'text/ecmascript-6+module', DirectiveProcessor
end
