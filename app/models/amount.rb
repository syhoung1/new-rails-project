class Amount < ActiveRecord::Base
  def self.default
    return 15
  end
end
