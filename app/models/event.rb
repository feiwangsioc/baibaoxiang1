class Event < ApplicationRecord

  validates_presence_of :name, :friendly_id

  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/
  before_validation :generate_friendly_id, :on => :create
  has_many :tickets, :dependent => :destroy, :inverse_of  => :event
  accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

    def to_param
      self.friendly_id
    end


    def generate_friendly_id
      self.friendly_id ||= SecureRandom.uuid
    end

    STATUS = ["draft", "public", "private"]
    validates_inclusion_of :status, :in => STATUS

    belongs_to :category, :optional => true

end
