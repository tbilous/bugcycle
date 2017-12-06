uri = URI.parse(ENV["REDIS_URL"] || "redis://localhost:6379/" )
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password, expires_in: 60.minutes)

