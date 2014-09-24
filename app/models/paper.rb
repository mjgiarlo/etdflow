class Paper < ActiveFedora::Base
  include CurationConcern::Work

  has_metadata 'descMetadata', type: PaperMetadata

  has_attributes :creator, :semester, :year, :program, :degree, :defense_date,
    :abstract, :title, :status, datastream: :descMetadata, multiple: false
  has_attributes :advisor, :keyword, datastream: :descMetadata, multiple: true
end
