Rack::Attack.throttle('limit logins per email', limit: 6, period: 60) do |req|
  if req.path == '/auth/sign_in' && req.post?
    req.params['email'].to_s.downcase.gsub(/\s+/, "")
  end
end

Rack::Attack.throttle("requests by ip", limit: 5, period: 2) do |request|
  request.ip
end

Rack::Attack.throttled_responder = lambda do |request|
  [ 503, {}, ["Server Error\n"]]
end
