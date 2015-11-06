require 'slip'
require 'thor'

module Slip
  class CLI < Thor
    include Thor::Actions

    include On
    include Source

    class_option :verbose, aliases: :v, type: :boolean, desc: 'verbose mode'

    # desc 'info NAME', 'NAME is what changes to the Gemfile, config/application.rb, etc.'
    # def info(name)
    # end
    #
    # desc 'list', 'Print installed NAME'
    # def list
    # end
    #
    # desc 'off NAME', 'Uninstall NAME ( ex. slip off devise )'
    # def off(name)
    # end

    desc 'on NAME', 'Install and setup a NAME'
    long_desc <<-LONGDESC.tr("\n", "\x5")
    support this.

    $ slip on #{ENV['HOME']}/some/rails

    $ slip on https://github.com/foo/bar.git
    $ slip on git://github.com/foo/bar.git
    $ slip on foo/bar
    LONGDESC
    def on(name)
      src_dir = source(name)
      dst_dir = '~/work/rails424/' # Dir.pwd
      source_files(src_dir) do |src_fullpath|
        dst_fullpath = File.expand_path("#{dst_dir}/#{src_fullpath.sub(/^#{src_dir}/, '')}")
        puts "#{src_fullpath} -> #{dst_fullpath}" if options[:verbose]

        if File.exist? dst_fullpath
          replace(src_fullpath, dst_fullpath)
        else
          STDERR.puts "File not found: #{dst_fullpath}"
        end
      end
    end

    desc 'version', 'Print version'
    def version
      puts "Slip #{Slip::VERSION}"
    end
  end
end
