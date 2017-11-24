class PrototypeTag < ActiveRecord::Base
  belongs_to :prototype
  belongs_to :tag
end
