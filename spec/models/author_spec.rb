# frozen_string_literal: true

require "rails_helper"

RSpec.describe Author, type: :model do
  it { is_expected.to have_and_belong_to_many :prints }

  it { is_expected.to validate_presence_of :name }
end
