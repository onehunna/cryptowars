class AssetRefreshWorker
  include Sidekiq::Worker

  def perform
    data = Coinmarketcap.fetch
    data.each do |asset|
      Asset.update_data(asset)
    end
  end
end
