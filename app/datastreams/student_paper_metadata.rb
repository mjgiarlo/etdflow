class StudentPaperMetadata < ActiveFedora::NtriplesRDFDatastream
  property :title, predicate: RDF::DC.title do |index|
    index.as :stored_searchable
  end
  property :creator, predicate: RDF::DC.creator do |index|
    index.as :stored_searchable
  end
  property :abstract, predicate: RDF::DC.abstract do |index|
    index.as :stored_searchable
    index.type :text
  end
  property :keyword, predicate: RDF::DC11.subject do |index|
    index.as :stored_searchable, :facetable
  end
  property :advisor, predicate: RDF::URI('http://id.loc.gov/vocabulary/relators/ths') do |index|
    index.as :stored_searchable
  end
  property :semester, predicate: Etdflow::Vocabularies::Etd.semester do |index|
    index.as :facetable
  end
  property :year, predicate: Etdflow::Vocabularies::Etd.year do |index|
    index.as :facetable
  end
  property :program, predicate: Etdflow::Vocabularies::Etd.program do |index|
    index.as :stored_searchable, :facetable
  end
  property :degree, predicate: Etdflow::Vocabularies::Etd.degree do |index|
    index.as :facetable
  end
  property :status, predicate: Etdflow::Vocabularies::Etd.status do |index|
    index.as :facetable
  end
  property :defense_date, predicate: Etdflow::Vocabularies::Etd.dateDefended do |index|
    index.as :stored_sortable
    index.type :date
  end
end
