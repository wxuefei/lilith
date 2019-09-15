class SliceWriter

  getter slice, offset
  
  def initialize(@slice : Slice(UInt8), @skip = -1)
    @offset = 0
  end
  
  macro fwrite?(writer, data)
    unless ({{ writer }} << {{ data }})
      return writer.offset
    end
  end
  
  def putc(ch)
    if @skip > 0
      @skip -= 1
      return
    end
    @slice[@offset] = ch
    @offset += 1
  end
  
  def puts(ch : Char)
    putc(ch.ord.to_u8)
  end
  
  def puts(ch : Int32)
    putc(ch.to_u8)
  end
  
  def puts(str : String)
    str.each do |ch|
      putc(ch)
    end
  end
  
  def <<(other)
    other.to_s self
    @offset != @slice.size
  end
  
end