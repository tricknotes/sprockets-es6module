require 'sprockets/es6module/version'

require 'esperanto'

module Sprockets
  class ES6Module
    def self.instance
      @instance ||= new
    end

    def self.call(input)
      instance.call(input)
    end

    def initialize(options = {})
      @options = options.dup.freeze

      @cache_key = [
        self.class.name,
        Esperanto::VERSION,
        VERSION
      ].freeze
    end

    def call(input)
      module_name = File.basename(input[:name], '.*')
      data = input[:data]
      options = @options.reverse_merge(amdName: module_name)
      result = input[:cache].fetch(@cache_key + [options, data]) do
        Esperanto.transform(data, options)
      end
      result['code']
    end
  end

  register_mime_type 'text/ecmascript-6+module', extensions: ['.es6module'], charset: :unicode
  register_transformer 'text/ecmascript-6+module', 'text/ecmascript-6', ES6Module
  register_preprocessor 'text/ecmascript-6+module', DirectiveProcessor
end
