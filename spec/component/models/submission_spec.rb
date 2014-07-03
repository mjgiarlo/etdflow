require 'component/component_spec_helper'

describe Submission do

  specify { expect(subject).to have_db_column :author_id }
  specify { expect(subject).to have_db_column :program_id }
  specify { expect(subject).to have_db_column :degree_id }
  specify { expect(subject).to have_db_column :semester }
  specify { expect(subject).to have_db_column :year }

  specify { expect(subject).to validate_presence_of :author_id }
  specify { expect(subject).to validate_presence_of :program_id }
  specify { expect(subject).to validate_presence_of :degree_id }
  specify { expect(subject).to validate_presence_of :semester }
  specify { expect(subject).to validate_presence_of :year }

  specify { expect(subject).to ensure_inclusion_of(:semester).in_array(Submission::SEMESTERS) }

  specify { expect(subject).to validate_numericality_of :year }
end
