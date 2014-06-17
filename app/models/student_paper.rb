class StudentPaper < ActiveFedora::Base
  include Worthwhile::CurationConcern::Work

  has_metadata 'descMetadata', type: StudentPaperMetadata

  has_attributes :creator, :semester, :year, :program, :degree, :defense_date,
    :abstract, :title, :status, datastream: :descMetadata, multiple: false
  has_attributes :advisor, :keyword, datastream: :descMetadata, multiple: true
end
