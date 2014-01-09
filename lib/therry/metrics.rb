class Metric
  @@paths = []

  def self.all
    @@paths
  end

  def self.find(search)
    search_pattern = /#{search}/i
    @@paths.select { |p| search_pattern.match(p) }
  end

  def self.load
    self.update
  end

  def self.update
    u = URI.parse(ENV['GRAPHITE_URL'])
    if (!ENV['GRAPHITE_USER'].empty? && !ENV['GRAPHITE_PASS'].empty?)
      u.user = ENV['GRAPHITE_USER']
      u.password = CGI.escape(ENV['GRAPHITE_PASS'])
    end
    response = RestClient.get("#{u.to_s}/metrics/index.json")
    @@paths = JSON.parse(response)
  end
end

