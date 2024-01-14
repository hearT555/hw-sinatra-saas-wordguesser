class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

    
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  

  def guess(letter)
    if @word.include?(letter)
      @guesses += letter
      true
    else
      @wrong_guesses += letter
      false
    end
  end

  def guess(letter)
    raise ArgumentError, 'Invalid guess' if letter.nil? || letter.empty? || !letter.match?(/[a-zA-Z]/)
  
    letter = letter.downcase
  
    if @word.include?(letter)
      @guesses << letter unless @guesses.include?(letter)
      true
    else
      @wrong_guesses << letter unless @wrong_guesses.include?(letter)
      false
    end
  end

  def guess(letter)
    raise ArgumentError, 'Invalid guess' if letter.nil? || letter.empty? || !letter.match?(/[a-zA-Z]/)

    letter = letter.downcase

    if @word.include?(letter)
      @guesses << letter unless @guesses.include?(letter)
      true
    else
      @wrong_guesses << letter unless @wrong_guesses.include?(letter)
      false
    end
  end

  def word_with_guesses
    result = ''
    
    @word.chars.each do |letter|
      result += @guesses.include?(letter) ? letter : '-'
    end
    
    result
  end

  def check_win_or_lose
    return :win if all_letters_guessed?
    return :lose if @wrong_guesses.length >= 7

    :play
  end

  private

  def all_letters_guessed?
    @word.chars.all? { |letter| @guesses.include?(letter) }
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    require 'attr_accessor'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
