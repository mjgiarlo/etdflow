require 'component/component_spec_helper'

describe CommitteeMember do

  specify { expect(subject).to have_db_column :submission_id }
  specify { expect(subject).to have_db_column :role          }
  specify { expect(subject).to have_db_column :name          }
  specify { expect(subject).to have_db_column :email         }
  specify { expect(subject).to have_db_column :is_advisor    }

  specify { expect(subject).to validate_presence_of :submission_id }
  specify { expect(subject).to validate_presence_of :role          }
  specify { expect(subject).to validate_presence_of :name          }
  specify { expect(subject).to validate_presence_of :email         }
  specify { expect(subject).to validate_presence_of :is_advisor    }

  specify { expect(subject).to belong_to :submission }
end
