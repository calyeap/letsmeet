class Event < ApplicationRecord
  belongs_to :user, polymorphic: true
end
