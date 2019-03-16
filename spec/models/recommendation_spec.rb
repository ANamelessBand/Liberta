# frozen_string_literal: true

require "rails_helper"

RSpec.describe Recommendation, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :print }

  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :print_id }

  it { expect(create(:recommendation)).to validate_uniqueness_of(:print_id).scoped_to(:user_id) }
end
