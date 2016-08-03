class Coinmarketcap
  API_HOST = 'https://api.coinmarketcap.com'

  def self.fetch
    conn = Faraday.new(:url => API_HOST)
    response = conn.get '/v1/ticker/'

    if response.success?
      return JSON.parse(response.body)
    else
      raise "LOL WTF"
    end
  end
end
