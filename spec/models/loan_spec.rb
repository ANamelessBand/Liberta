# frozen_string_literal: true

require "rails_helper"

RSpec.describe Loan, type: :model do
  it { is_expected.to belong_to :copy }
  it { is_expected.to belong_to :user }
end
