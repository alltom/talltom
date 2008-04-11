require "rexml/document"

class Page < ActiveRecord::Base
  has_many :versions, :class_name => "PageVersion",
    :order => "created_on ASC", :dependent => :destroy
  belongs_to :current_version, :class_name => "PageVersion",
    :foreign_key => "current_version_id"

  @@slug_format = /^[a-z\-0-9\.]+$/

  validates_presence_of :title
  validates_format_of :slug, :with => @@slug_format
  validates_uniqueness_of :slug

  def before_validation
    unless (self.slug =~ @@slug_format) || self.frozen?
      self.slug = generate_slug(self.title)
    end
  end

  def to_param
    self.slug
  end

  def modified?
    return false if current_version.nil?
    return false if versions.count <= 1
    return true
  end

  class << self
    def find_all
      find(:all, :include => :current_version,
          :conditions => "current_version_id IS NOT NULL",
          :order => "publish_date DESC")
    end

    def find_recent
      find(:all, :include => :current_version,
          :conditions => "current_version_id IS NOT NULL",
          :order => "publish_date DESC", :limit => 20)
    end

    def find_for_rss
      find(:all, :include => :current_version,
          :conditions => "current_version_id IS NOT NULL AND show_in_rss = 1",
          :order => "publish_date DESC", :limit => 15)
    end
  end

  private

    def generate_slug(title)
      return "" unless title
      title.downcase.delete("'\"").gsub(/[^A-Za-z0-9\.]+/,' ').strip.gsub(' ','-')
    end
end

class PageVersion < ActiveRecord::Base
  belongs_to :page
  
  validates_presence_of :body
  validates_presence_of :publish_date
  validates_presence_of :page
  validates_associated :page
  validates_each :body do |record, attr, value|
    begin
      REXML::Document.new("<doc>" + value.to_s + "</doc>")
    rescue REXML::ParseException
      record.errors.add attr, "is not valid XML"
    end
  end

  def before_save
    unless self.version
      last_version = PageVersion.maximum(:version, :conditions => [ 'page_id = ?', self.page_id ])
      self.version = (last_version || 0) + 1
    end
  end
end

class NewsUpdate < ActiveRecord::Base
  validates_presence_of :body
  validates_each :body do |record, attr, value|
    begin
      REXML::Document.new("<doc>" + value.to_s + "</doc>")
    rescue REXML::ParseException
      record.errors.add attr, "is not valid XML"
    end
  end

  def self.latest
    find(:first, :order => "created_on DESC")
  end
end

class Project < ActiveRecord::Base
  belongs_to :page

  validates_presence_of :title
  validates_associated :page

  def self.find_all
    find(:all, :order => "updated_at DESC, created_at DESC")
  end
end
