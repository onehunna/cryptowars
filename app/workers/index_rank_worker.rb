class IndexRankWorker
  include Sidekiq::Worker

  def perform
    Index.all.each(&:recalculate)
  end
end

