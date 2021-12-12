#!/usr/bin/env ruby
require 'json'
require 'fileutils'

FileUtils.mkdir_p("packages")

flink_download_html = 'packages/flink-download.html'
flink_versions_json = 'packages/flink-versions.json'
`curl https://flink.apache.org/downloads > #{flink_download_html}` unless File.exist?(flink_download_html)

flink_download_text = IO.read(flink_download_html)
# flink-1.14.0-bin-scala_2.11.tgz
flink_versions = flink_download_text.scan(/(flink-(([\d\.?]+)-bin-scala_([\d\.?]+))\.tgz)/).uniq.map.with_index do |pattern, index|
    puts "- `#{pattern[1]}`" if index < 20

    {
        version: pattern[1],
        flink_version: pattern[3],
        scala_version: pattern[2],
        filename: pattern[0]
    }
end

File.open(flink_versions_json, "w:utf-8") do |file|
    file.puts(JSON.pretty_generate(flink_versions))
end
puts "View all flink versions in #{flink_versions_json}."