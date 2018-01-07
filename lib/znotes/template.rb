require 'erb'

module Znotes
  module Template
    class Post
      attr_reader :title, :template

      TEMPLATE_PATH = File.join(__dir__, 'templates', 'post.md.erb').freeze

      class << self
        def render(*args)
          self.new(*args).render
        end
      end

      def initialize(title:)
        @title = title
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end

      def render
        ERB.new(template).result(binding)
      end
    end
  end
end
