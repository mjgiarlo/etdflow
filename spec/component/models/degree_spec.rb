require 'component/component_spec_helper'

describe Degree do

  it { should have_db_column :name }
  it { should have_db_column :description }
  it { should have_db_column :degree_type }
  it { should have_db_column :is_active }

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :degree_type }

end
