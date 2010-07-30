class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :replies
  MAX_SUBJECT_LENGTH = 40
  MIN_SUBJECT_LENGTH = 1
  MAX_BODY_LENGTH = 90000
  MIN_BODY_LENGTH = 1
  SUBJECT_LENGTH_RANGE = MIN_SUBJECT_LENGTH..MAX_SUBJECT_LENGTH
  BODY_LENGTH_RANGE = MIN_BODY_LENGTH..MAX_BODY_LENGTH

  validates_length_of :subject, :within => SUBJECT_LENGTH_RANGE
  validates_length_of :body, :within => BODY_LENGTH_RANGE
  validates_presence_of :user_id, :topic_id,:messages=>""
end
