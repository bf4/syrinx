require "./lib/tweet"
require "./lib/tweet_importer"
require "./lib/category"
require "./lib/categorizes_tweets"
require "./lib/link_filter"

# import tweets
tweet_importer = TweetImporter.new
tweets = tweet_importer.import!

# categorize them
categorizes_tweets = CategorizesTweets.new
ruby = Category.new(:ruby, ["ruby"])
music = Category.new(:music, ["music"])
categorizes_tweets.categories = [ruby, music]
categorized = categorizes_tweets.categorize!(*tweets)

# get tweets with links
tweets_with_links = categorized.inject({}) do |memo, (category, tweets)|
  memo[category] = LinkFilter.collect_tweets_with_links(tweets)
  memo
end

# shell output
puts
puts "new links by category!"
tweets_with_links.each do |category, tweets|
  next if tweets.empty?
  puts category
  tweets.each do |tweet|
    puts "  " + LinkFilter.extract_link(tweet.text) + "        (via #{tweet.username})"
  end
end
puts

