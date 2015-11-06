module On
  def replace(src_fullpath, dst_fullpath)
    src = File.readlines(src_fullpath)
    dst = File.read(dst_fullpath)

    if dst.include?(src.first)
      puts "  First match: #{src_fullpath} ( #{src.first} )" if @options[:verbose]
      insert_into_file dst_fullpath, src.slice(1, src.size).join, after: src.first
    elsif dst.include?(src.last)
      puts "  Last match: #{src_fullpath} ( #{src.last} )" if @options[:verbose]
      insert_into_file dst_fullpath, src.slice(0, src.size - 1).join, before: src.last
    else
      puts "  No match: #{src_fullpath}" if @options[:verbose]
      append_to_file dst_fullpath, src.join
    end
  end
end
