# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :user_id }

  subject { create(:notification) }

  it "defaults to unread" do
    expect(subject.read).to be false
  end

  describe "#read!" do
    it "marks a notification as read" do
      subject.read!
      expect(subject.read).to be true
    end
  end
end
