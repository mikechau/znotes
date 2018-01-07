module Znotes
  module Utils
    def self.format_timestamp(date:)
      date.strftime("%F_%H-%M-%S")
    end

    def self.slugify(prepend_title: nil, title:)
      slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

      if prepend_title && prepend_title != ''
        "#{prepend_title}___#{slug}"
      else
        "#{slug}"
      end
    end
  end
end
