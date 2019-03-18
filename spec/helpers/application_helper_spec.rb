# frozen_string_literal: true

require "rails_helper"

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe "#navbar_item_class" do
    let (:path) { root_path }

    subject { helper.navbar_item_class(path) }

    it "contains 'navbar-item'" do
      expect(subject).to include "navbar-item"
      expect(subject).not_to include "is-active"
    end

    it "sets is-active when page is active" do
      allow(helper).to receive(:current_page?).with(root_path).and_return(true)
      expect(subject).to include "is-active"
    end
  end

  describe "#icon_with_text" do
    subject { helper.icon_with_text("plus", "random text", true) }

    it "contains correct icon" do
      expect(subject).to include "fa fa-plus"
    end

    it "contains text" do
      expect(subject).to include "random text"
    end

    it "sets is-small" do
      expect(subject).to include "icon is-small"
    end
  end

  describe "#authors_html" do
    let (:author1) { create :author, name: "George" }
    let (:author2) { create :author, name: "Jack" }
    let (:print) { create :print, authors: [author1, author2] }

    subject { helper.authors_html(print) }

    it "contains authors" do
      expect(subject).to include "George"
      expect(subject).to include "Jack"
    end

    it "contains links" do
      expect(subject).to include author_path(author1)
      expect(subject).to include author_path(author2)
    end
  end

  describe "#stars_span" do
    it "renders correct html" do
      html = helper.stars_span(3.0)

      expect(html).to include "span"
      expect(html).to include "stars s-3"
      expect(html).to include "3 stars"
    end

    it "rounds" do
      expect(helper.stars_span(2.3)).to include "2.5 stars"
      expect(helper.stars_span(2.8)).to include "3 stars"
      expect(helper.stars_span(3.1)).to include "3 stars"
    end

    context "when interactive" do
      it "adds interactive class" do
        expect(helper.stars_span(3.0, true)).to include "stars s-3 interactive"
      end

      it "contains hidden input tag" do
        expect(helper.stars_span(3.0, true)).to include hidden_field_tag("rating", 3.0)
      end

      it "converts to_f" do
        expect(helper.stars_span(3, true)).to include hidden_field_tag("rating", 3.0)
      end
    end
  end

  describe "#print_cover" do
    context "when print has cover url" do
      let (:print) { create :print, cover_url: "http://cover-url" }
      subject { helper.print_cover(print) }

      it "renders image tag for print cover" do
        expect(subject).to include "http://cover-url"
      end

      it "renders image as async" do
        expect(subject).to include "async"
      end
    end

    context "when print has no cover url" do
      let (:print) { create :print, cover_url: nil }

      it "renders default image tag" do
        expect(helper.print_cover(print)).to include "book-cover-placeholder.jpg"
      end
    end

    context "css class" do
      let (:print) { create :print }

      it "renders default class" do
        expect(helper.print_cover(print)).to include 'class="cover"'
      end

      it "can render custom class" do
        expect(helper.print_cover(print, "custom_class")).to include 'class="custom_class"'
      end
    end
  end
end
