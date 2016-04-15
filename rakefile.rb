require 'time'

desc 'create a new draft post'
task :post do
  title = ENV['title']
  slug = "#{Date.today}-#{title.downcase.gsub(/[^\w]+/, '-')}"

  file = File.join(
    File.dirname(__FILE__),
    '_posts',
    slug + '.md'
  )

  File.open(file, "w") do |f|
    f << <<-EOS.gsub(/^    /, '')
    ---
    layout: post
    title: #{title}
    published: false
    author: "redbyzan"
    categories:
    ---

    EOS
  end

  system ("#{ENV['EDITOR']} #{file}")
end