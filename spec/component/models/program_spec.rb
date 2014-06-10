require 'component/component_spec_helper'

describe Program do

  it { should have_db_column :description }
  it { should have_db_column :is_active }

  it { should validate_presence_of :description }

end
