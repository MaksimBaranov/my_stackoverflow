class ChecksumGenerator
  attr_accessor :checksum

  def initialize
    @checksum = Array.new(20){[*'A'..'Z', *0..9, *'a'..'z'].sample}.join
  end
end
