class HomePageController < ApplicationController
  def show
    render file: File.join(Rails.root, 'vendor', 'landing.html'), status: 200
  end
end
