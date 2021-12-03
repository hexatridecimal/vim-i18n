#!/usr/bin/env ruby

yaml   = ARGV.shift # Fully qualified path to yaml, e.g. "/Users/hallelujah/dev/brightfunds/config/locales/en.yml"
file   = ARGV.shift
key    = ARGV.shift
value  = ARGV.shift
basename = File.basename(file, ".html.slim")
repo = "#{ENV['CURRENT_RAILS_REPO']}/app/views" # Path to repo with views only e.g.: "/Users/hallelujah/dev/brightfunds/app/views"
path = file.gsub(/^#{repo}/, '')
path_parts = path.split("/")
path_parts.pop
path_parts[0] = "en"
path_parts.unshift ""
path_parts.push basename
path_parts.push key

yaml_set = File.expand_path(__FILE__).split("/")
yaml_set.pop
yaml_set.push "yaml_set.py"
yaml_set = yaml_set.join("/")

# ./yaml_set.py -g /en/admin/allocations/index/donation_id -a "Donation ID" ~/dev/brightfunds/config/locales/en.yml
args = [yaml_set, "-g", path_parts.join("/"), "-a", value, yaml]
#File.open("/tmp/test.txt", "w") do |f|
#  f.puts args.join(" ")
#end
system *args
#File.open("/tmp/test.txt", "a") do |f|
#  f.puts $? ? "true" : "false"
#end

