module Source
  def source_files(path)
    Dir.glob(path + '/**/*') do |file|
      next unless File.file? file
      next if File.basename(file) == 'Slipfile'
      yield file
    end
  end

  def source(name)
    name.sub(%r{/$}, '')
  end
end
