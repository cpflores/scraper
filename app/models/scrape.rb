class Scrape
  attr_accessor :title, :hotness, :image_url, :rating, :director,
                :failure # :runtime, :synopsis, :genre

  def scrape_new_movie(url)
    begin
      doc = Nokogiri::HTML(open(url))
      doc.css('script').remove
      self.title = doc.at("//h1[@data-type = 'title']").text
      self.hotness = doc.at("//span[@class = 'superPageFontColor']").text.to_i
      self.image_url = doc.at_css('#poster_link img')['src']
      self.rating = doc.at("//div[@class = 'col col-sm-19 col-xs-14 text-left']").text
      self.director = doc.at("//div[@class = 'col-sm-19 col-xs-14 text-left']").css('a').first.text
      # self.genre
      # self.runtime
      # self.synopsis
      return true
    rescue Exception => e
      self.failure = "Something went wrong with the scrape."
    end
  end

end
