require 'digest'

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

def pad(str, times)
  (0..str.size-times).each do |i|
    if str[i...i + times].chars.uniq.size == 1
      return str[i]
    end
  end
  false
end

def stretched_hash(str)
  2016.times { str = Digest::MD5.hexdigest str }
  str
end

def pad_key(input, stretched)
  ind = 0
  pads = {
    '3' => {},
    '5' => {}
  }
  pad_keys = []
  until pad_keys[63] && pad_keys[63] < ind - 1000
    hex = Digest::MD5.hexdigest "#{input}#{ind}"
    hex = stretched_hash hex if stretched
    pad3 = pad(hex, 3)
    pad5 = pad(hex, 5)
    if pad3
      pads['3'][pad3] ||= []
      pads['3'][pad3] << ind
    end
    if pad5
      pads['5'][pad5] ||= []
      pads['5'][pad5] << ind

      pad_keys += pads['3'][pad5].filter { _1 >= ind - 1000 && _1 < ind}
      pad_keys = pad_keys.uniq.sort
    end
    ind += 1
  end

  pad_keys[63]
end

p pad_key(input, false)
p pad_key(input, true)
