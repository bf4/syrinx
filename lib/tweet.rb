class Tweet < Struct.new(
  :id,
  :timestamp,
  :username,
  :text)

  attr_accessor :retweets

  def self.create(attributes)
    new(
      attributes[0].to_i,
      attributes[1],
      attributes[2],
      attributes[3]
    )
  end
end

