class User < ActiveRecord::Base
  validates :email, format: {
    with: /@s\d{1,}\.tku\.edu\.tw$/,
    message: 'Must be tku email!'
  }
end
