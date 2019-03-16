# frozen_string_literal: true

require "rails_helper"

RSpec.describe Copy, type: :model do
  it { is_expected.to have_many :loans }
  it { is_expected.to belong_to :print }

  it { is_expected.to validate_presence_of :print_id }
  it { is_expected.to validate_presence_of :inventory_number }
  it { is_expected.to validate_numericality_of :inventory_number }
end
