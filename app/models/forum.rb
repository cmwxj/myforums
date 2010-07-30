class Forum < ActiveRecord::Base
  has_many :topics
  has_many :replies, :through => :topics
  MAX_NAME_LENGTH = 20
  MIN_NAME_LENGTH = 1
  MAX_DESCRIPTION_LENGTH = 200
  MIN_DESCRIPTION_LENGTH = 1
  NAME_LENGTH_RANGE = MIN_NAME_LENGTH..MAX_NAME_LENGTH
  DESCRIPTION_LENGTH_RANGE = MIN_DESCRIPTION_LENGTH..MAX_DESCRIPTION_LENGTH

  validates_length_of :name, :within => NAME_LENGTH_RANGE
  validates_length_of :description, :within => DESCRIPTION_LENGTH_RANGE
end
