def substrings(text, dictionary)
  dictionary.reduce(Hash.new(0)) do |result, dict|
    if text.include?(dict)
      result[dict] += 1
    end
    result
  end
  
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
#puts substrings("below", dictionary) => { "below" => 1, "low" => 1 }
puts substrings("Howdy partner, sit down! How's it going?", dictionary) #=> { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
