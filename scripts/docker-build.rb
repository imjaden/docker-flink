#!/usr/bin/env ruby -w
require 'json'
require 'open3'
require 'fileutils'

def execute_bash_command_output(thread_index, output)
    # pid##{Process.pid}
    puts "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}(thread##{thread_index}) - #{output}"
end

def execute_bash_command(thread_index, command_string)
    Open3::popen3(command_string) do |stdin, stdout, stderr, wait_thr|
        while line = stdout.gets
            execute_bash_command_output(thread_index, line)
        end
        execute_bash_command_output(thread_index, "done! thread will be destroyed!")
    end
end

def execute_bash_lambda(bash_pattern)
    threads = @expect_versions.map.with_index do |pattern, index|
        # Thread.new(pattern, index) do |pattern, index|
            command_string = "#{bash_pattern} #{pattern['flink_version']} #{pattern['scala_version']}"
            execute_bash_command_output(index, command_string)
            execute_bash_command(index, command_string)
        # end
    end
    # threads.map(&:join)
end

FileUtils.mkdir_p("packages")

flink_versions_json = 'packages/flink-versions.json'
execute_bash_command(0, "ruby scripts/flink-versions.rb") unless File.exist?(flink_versions_json)

flink_versions = JSON.parse(IO.read(flink_versions_json))
@expect_versions = flink_versions.select { |pattern| !pattern['flink_version'].include?('beta') }
    .sort_by { |pattern| pattern['flink_version'] }
    .reverse
    .first(5)
    .reverse

execute_bash_lambda "bash scripts/docker-build.sh"
