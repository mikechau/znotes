RSpec.describe Znotes do
  before(:all) do
    FileUtils.rm_rf(Dir["#{__dir__}/output"], secure: true)
    FileUtils.mkdir("#{__dir__}/output")
  end

  it "has a version number" do
    expect(Znotes::VERSION).not_to be nil
  end

  it "creates a page" do
    time = Time.utc(2018, 1, 2, 3, 4, 5)

    Timecop.freeze(time) do
      results = Znotes.create_page!(
        base_dir: __dir__,
        output_path: "output",
        category: "test-subject",
        title: "How to Create a Page"
      )

      expect(results).to have_attributes({
        file_path: "output/test-subject/2018-01-02_03-04-05___how-to-create-a-page/post.md",
        title: "How to Create a Page",
        file_name: "post.md",
        title_slug: "2018-01-02_03-04-05___how-to-create-a-page",
        timestamp: "2018-01-02T03:04:05+00:00",
        category: "test-subject",
        output_path: "output",
        path: "/output/test-subject/2018-01-02_03-04-05___how-to-create-a-page",
        local_path: "output/test-subject/2018-01-02_03-04-05___how-to-create-a-page"
      })

      expect(File).to exist(File.join(__dir__, results.file_path))

      content = File.read(File.join(__dir__, results.file_path))

      expect(content).to eq("# How to Create a Page\n\n")
    end
  end

  it "saves metadata" do
    metadata = {
      file_path: "output/test-subject/2018-01-02_03-04-05___how-to-create-a-page/post.md",
      title: "How to Create a Page",
      file_name: "post.md",
      title_slug: "2018-01-02_03-04-05___how-to-create-a-page",
      timestamp: "2018-01-02T03:04:05+00:00",
      category: "test-subject",
      output_path: "output",
      path: "/output/test-subject/2018-01-02_03-04-05___how-to-create-a-page",
      local_path: "output/test-subject/2018-01-02_03-04-05___how-to-create-a-page"
    }

    Znotes.save_metadata!(metadata: metadata, path: "#{__dir__}/output/test-subject/2018-01-02_03-04-05___how-to-create-a-page/metadata.yml")

    expect(File).to exist("#{__dir__}/output/test-subject/2018-01-02_03-04-05___how-to-create-a-page/metadata.yml")

    content = YAML.load_file("#{__dir__}/output/test-subject/2018-01-02_03-04-05___how-to-create-a-page/metadata.yml")

    expect(content).to include({
      "file_path" => "output/test-subject/2018-01-02_03-04-05___how-to-create-a-page/post.md",
      "title" => "How to Create a Page",
      "file_name" => "post.md",
      "title_slug" => "2018-01-02_03-04-05___how-to-create-a-page",
      "timestamp" => "2018-01-02T03:04:05+00:00",
      "category" => "test-subject",
      "output_path" => "output",
      "path" => "/output/test-subject/2018-01-02_03-04-05___how-to-create-a-page",
      "local_path" => "output/test-subject/2018-01-02_03-04-05___how-to-create-a-page"
    })
  end

  xit "creates a table of contents for a category" do
  end
end
