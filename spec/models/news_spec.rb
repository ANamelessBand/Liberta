# frozen_string_literal: true

require "rails_helper"

RSpec.describe News, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :content }
end
