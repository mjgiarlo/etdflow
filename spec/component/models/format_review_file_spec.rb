require 'component/component_spec_helper'

describe FormatReviewFile do

  specify { expect(subject).to have_db_column :submission_id }
  specify { expect(subject).to have_db_column :asset }
  specify { expect(subject).to have_db_column :created_at }
  specify { expect(subject).to have_db_column :updated_at }

  specify { expect(subject).to validate_presence_of :asset }
  specify { expect(subject).to validate_presence_of :submission_id }

  specify { expect(subject).to belong_to :submission }

end
