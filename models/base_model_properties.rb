# frozen_string_literal: true

module BaseModelProperties
  def self.included(base)
    base.class_eval do
      include DataMapper::Resource

      # Basic fields
      property :id, DataMapper::Property::Serial
      property :created_at, DateTime
      property :updated_at, DateTime
    end
  end
end
