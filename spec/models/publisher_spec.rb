# frozen_string_literal: true

require "rails_helper"

RSpec.describe Publisher, type: :model do
  it { is_expected.to have_many :prints }

  it { is_expected.to validate_presence_of :name }
end
