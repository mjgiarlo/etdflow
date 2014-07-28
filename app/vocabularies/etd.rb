module Etdflow::Vocabularies
  class Etd < RDF::StrictVocabulary('http://opaquenamespace.org/etd/')
    property :semester, label: 'Semester of paper submission'
    property :year, label: 'Year of paper submission'
    property :program, label: 'Disciplinary program'
    property :degree, label: 'Degree affiliation'
    property :status, label: 'Status of paper submission'
    property :dateDefended, label: 'Date of paper defense'
  end
end
