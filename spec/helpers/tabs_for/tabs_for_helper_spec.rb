require "spec_helper"

describe TabsFor::TabsForHelper do

  let(:people) {[
    Person.new("Person 1", "Last Name 1"),
    Person.new("Person 2", "Last Name 2"),
  ]}
  let(:company) do
    Company.new("Willis Corp", people)
  end

  describe TabsFor::TabsForHelper::TabBuilder do

    def builder(object)
      TabsFor::TabsForHelper::TabBuilder.new(object, ActionView::Base.new)
    end

    it "renders a tab" do
      expect(builder(company).tab(:name, :size => company.people.size)).to eq(
        "<li role=\"presentation\">" +
        "<a aria-controls=\"name\" data-toggle=\"tab\" role=\"tab\" href=\"#name\">" +
        "name <span class=\"badge\">2</span>" +
        "</a>" +
        "</li>"
      )
    end

    context "options[:active]" do
      it "renders the tab to active" do
        expect(builder(company).tab(:name, :active => true)).to match(
          /<li role=\"presentation\" class=\"active\">/
        )
      end
    end
  end

  describe TabsFor::TabsForHelper::PaneBuilder do

    def builder(object)
      TabsFor::TabsForHelper::PaneBuilder.new(object, ActionView::Base.new)
    end

    it "renders a tab pane" do
      expect(builder(company).tab(:name) { "some content" }).to eq(
        "<div role=\"tabpanel\" class=\"tab-pane\" id=\"name\">some content</div>"
      )
    end

    describe "options[:active]" do
      it "renders the pane as active" do
        expect(builder(company).tab(:name, active: true) { "some content" }).to match(
          /class=\"tab-pane active\"/
        )
      end
    end
  end

end
