#!/usr/bin/ruby

# EmlRipper.rb
#
# This script was created by Mystik to extract attachments from .eml files
#
# The script utilizes the Mail gem to parse .eml files from path||file
# Mail  is a library that provides a simple and elegant way to read, write and send emails.
# The .eml file format is a standard format for email messages, it's used
# to save emails on disk and to transfer them between different email
# clients and servers.

require 'bundler/inline'
$VERBOSE = nil

gemfile 'ripper.gemfile' do
  source "https://rubygems.org"
  gem 'mail'
  gem 'pathname'
  gem 'optparse'
  gem 'highline'
  gem 'fileutils'
  gem 'artii'
end
require 'highline/import'

a = Artii::Base.new :font => 'slant'
puts a.asciify('EmlRipper by Mystik')


def extractor(file, destination)
  puts "PROCESSING FILE #{file}"
  email_message = Mail.read(file)
  email_subject = email_message.subject
  basepath = File.join(destination, strip_bad_chars(email_subject))
  attachments = email_message.attachments.reject { |a| a.inline? }
  if attachments.empty?
    puts '>> No attachments found.'
    return
  end
  attachments.each do |attachment|
    filename = attachment.filename
    puts ">> Attachment found: #{filename}"
    filepath = File.join(basepath, filename)
    if File.exist?(filepath)
      overwrite = ask(">> The file #{filename} already exists! Overwrite it (Y/n)? ") { |q| q.validate = /\A[yn]\Z/i }
      if overwrite.upcase == 'Y'
        File.open(filepath, 'w') { |f| f.write(attachment.body.decoded) }
        puts ">> #{filename} saved!"
      else
        puts '>> Skipping...'
      end
    else
      FileUtils.mkdir_p(basepath) unless File.directory?(basepath)
      File.open(filepath, 'w') { |f| f.write(attachment.body.decoded) }
      puts ">> #{filename} saved!"
    end
  end
end

def strip_bad_chars(name)
  illegal_chars = /[\/\\|\[\]\{\}:<>+=;,?!*"~#$%&@']/
  name.gsub(illegal_chars, '_')
end

def fetch_eml(path, recursively = false)
  path = Pathname.new(path)
  if recursively
    return Dir.glob(File.join(path.to_path, '**', '*.eml')).map { |f| Pathname.new(f) }
  else
    return Dir.glob(File.join(path.to_path, '*.eml')).map { |f| Pathname.new(f) }
  end
end


def find_eml(arg_value)
  file = Pathname.new(arg_value)
  if file.file? && file.extname == '.eml'
    return file
  else
    raise ArgumentError, "#{file} is not a valid EML file."
  end
end

def find_eml_path(arg_value)
  path = Pathname.new(arg_value)
  if path.directory?
    return path
  else
    raise ArgumentError, "#{path} is not a valid directory."
  end
end

def argument_parser
  options = {}
  parser = OptionParser.new do |opts|
    opts.banner = 'Usage: script.rb [OPTIONS]'
    opts.on('-s', '--source PATH', 'the directory containing the .eml files to extract attachments (default: current working directory)') do |v|
      options[:source] = v
    end
    opts.on('-r', '--recursive', 'allow recursive search for .eml files under SOURCE directory') do |v|
      options[:recursive] = v
    end
    opts.on('-f', '--files FILE', 'specify a .eml file or a list of .eml files to extract attachments') do |v|
      options[:files] = v
    end
    opts.on('-d', '--destination PATH', 'the directory to extract attachments to (default: current working directory)') do |v|
      options[:destination] = v
    end
  end
  parser.parse!
  options[:source] = Dir.pwd unless options[:source]
  options[:destination] = Dir.pwd unless options[:destination]
  options
end

def main
  options = argument_parser
  if options[:files].nil? && options[:source].nil?
    puts "No files or source directory specified!"
    exit
  end
  eml_files = options[:files] ? [options[:files]] : fetch_eml(options[:source], options[:recursive])
  if eml_files.empty?
    puts 'No EML files found'
    exit
  end
  eml_files.each do |file|
    extractor(file, options[:destination])
  end
  puts 'Done.'
end

main()
