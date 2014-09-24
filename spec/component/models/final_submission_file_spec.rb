require 'component/component_spec_helper'

describe FinalSubmissionFile do

  specify { expect(subject).to have_db_column :submission_id }
  specify { expect(subject).to have_db_column :filename }
  specify { expect(subject).to have_db_column :created_at }
  specify { expect(subject).to have_db_column :updated_at }
  specify { expect(subject).to have_db_column :content_type }

  specify { expect(subject).to validate_presence_of :filename }
  specify { expect(subject).to validate_presence_of :submission_id }

  specify { expect(subject).to belong_to :submission }

end
