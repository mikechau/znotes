require 'fileutils'
require 'pathname'
require 'ostruct'
require 'date'
require "yaml/store"

require 'znotes/version'
require 'znotes/utils'
require 'znotes/template'

module Znotes
  def self.create_page!(base_dir:, output_path:, category: '', title:, file_name: 'post.md', date: DateTime.now)
    template = Template::Post.render(title: title)
    timestamp_slug = Utils.format_timestamp(date: date)

    title_slug = Utils.slugify(
      prepend_title: timestamp_slug,
      title: title
    )

    file_path = Pathname(File.join(base_dir, output_path, category, title_slug, file_name))
    base_path = Pathname(base_dir)

    file_path.dirname.mkpath
    file_path.write(template)

    metadata = OpenStruct.new({
      file_path: file_path.relative_path_from(base_path).to_s,
      title: title,
      file_name: file_name,
      title_slug: "#{title_slug}",
      timestamp: date.iso8601,
      category: category,
      output_path:output_path,
      path: File.join("/", file_path.dirname.relative_path_from(base_path)),
      local_path: file_path.dirname.relative_path_from(base_path).to_s
    })
  end

  def self.save_metadata!(metadata: {}, path:)
    store_path = Pathname(path)
    store_path.dirname.mkpath

    store = YAML::Store.new(store_path)

    store.transaction do
      metadata.each do |k, v|
        store[k.to_s] = v
      end
    end
  end
end
