class Amount < ActiveRecord::Base
  def self.default
    return 15_00
  end
end
