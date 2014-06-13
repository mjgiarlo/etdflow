require 'component/component_spec_helper'

describe Program do

  specify { expect(subject).to have_db_column :name }
  specify { expect(subject).to have_db_column :is_active }

  specify { expect(subject).to validate_presence_of :name }

end
