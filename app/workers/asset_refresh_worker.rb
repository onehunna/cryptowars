class AssetRefreshWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 5

  def perform
    data = Coinmarketcap.fetch
    data.each do |asset|
      Asset.update_data(asset)
    end

    Index.all.each(&:recalculate!)
    Index.all.each(&:cleanup_cache!)
  end
end
