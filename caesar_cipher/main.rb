def caesar_cipher(str, number)
  # upper_ascii = {min:65, max:90}
  # lower_ascii = {min: 97, max:122}
  new_str= ""
  number_ascii = str.codepoints
  
  number_ascii.each do |num|
    new_num = number + num
    if num >= 65 && num <= 90
      if new_num > 90
        new_num = new_num - 90 + 65 -1
      end
    elsif num >= 97 && num <= 122
      if new_num > 122
        new_num = new_num - 122 + 97-1
      end
    else
      new_num = num
    end
    new_str += new_num.chr
  end
  new_str
  
  
end
result = caesar_cipher("What a string!", 5)
print result