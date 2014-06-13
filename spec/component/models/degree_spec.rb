require 'component/component_spec_helper'

describe Degree do

  specify { expect(subject).to have_db_column :name }
  specify { expect(subject).to have_db_column :description }
  specify { expect(subject).to have_db_column :degree_type }
  specify { expect(subject).to have_db_column :is_active }

  specify { expect(subject).to validate_presence_of :name }
  specify { expect(subject).to validate_presence_of :description }
  specify { expect(subject).to validate_presence_of :degree_type }

  specify { expect(subject).to ensure_inclusion_of(:degree_type).in_array(Degree::DEGREE_TYPES) }

  specify { expect(subject).to validate_uniqueness_of :name }
end
