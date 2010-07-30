class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :replies
  MAX_SUBJECT_LENGTH = 50
  MIN_SUBJECT_LENGTH = 3
  MAX_BODY_LENGTH = 90000
  MIN_BODY_LENGTH = 5
  SUBJECT_LENGTH_RANGE = MIN_SUBJECT_LENGTH..MAX_SUBJECT_LENGTH
  BODY_LENGTH_RANGE = MIN_BODY_LENGTH..MAX_BODY_LENGTH

  validates_length_of :subject, :within => SUBJECT_LENGTH_RANGE
  validates_length_of :body, :within => BODY_LENGTH_RANGE
  validates_presence_of :user_id
end
