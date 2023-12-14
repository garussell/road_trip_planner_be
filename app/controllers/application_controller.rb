# frozen_string_literal: true

class ApplicationController < ActionController::API
  def fetch_or_cache(key)
    cached = Rails.cache.read(key)
    if cached.present?
      cached
    else
      data = yield
      Rails.cache.write(key, data, expires_in: 1.hour)
      data
    end
  end
end
