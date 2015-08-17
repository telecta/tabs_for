require "spec_helper"

describe TabsFor::TabsForHelper do

  let(:people) {[
    Person.new("Person 1", "Last Name 1"),
    Person.new("Person 2", "Last Name 2"),
  ]}
  let(:company) do
    Company.new("Willis Corp", people)
  end

  before do
    store_translations(:en, :activerecord => {:attributes => {:company => {:name => "Nome"}}})
  end

  describe TabsFor::TabsForHelper::TabBuilder do

    def builder(object)
      TabsFor::TabsForHelper::TabBuilder.new(object, ActionView::Base.new)
    end

    describe "#tab" do
      it "renders a tab" do
        expect(builder(company).tab(:name, :size => company.people.size)).to eq(
          "<li role=\"presentation\">" +
            "<a aria-controls=\"name\" data-toggle=\"tab\" role=\"tab\" href=\"#name\">" +
              "Nome <span class=\"badge\">2</span>" +
            "</a>" +
          "</li>"
        )
      end

      describe "when a string is given" do
        it "renders the tab with that string" do
          expect(builder(company).tab("Statistics")).to match(
            /Statistics/
          )
        end
      end

      describe "when a symbol is given" do
        describe "and it's a model attribute" do
          it "translates the attribute" do
            expect(builder(company).tab(:name)).to match(
              /Nome/
            )
          end
        end

        describe "it's not a model attribute" do
          it "convert to string and titelizes" do
            expect(builder(company).tab(:non_existent)).to match(
              /Non Existent/
            )
          end
        end
      end
    end

    context "options[:active]" do
      it "renders the tab to active" do
        expect(builder(company).tab(:name, :active => true)).to match(
          /<li role=\"presentation\" class=\"active\">/
        )
      end
    end

    context "options[:icon]" do
      it "wraps the tab text in an <i> tag" do
        expect(builder(company).tab(:name, :icon => "fa fa-building")).to eq(
          "<li role=\"presentation\">" +
            "<a aria-controls=\"name\" data-toggle=\"tab\" role=\"tab\" href=\"#name\">" +
            "<i class=\"fa fa-building\"> Nome</i>" +
            "</a>" +
          "</li>"
        )
      end
    end

    context "options[:title]" do
      it "overrides the title" do
        expect(builder(company).tab(:name, :title => "Custom Title")).to match(
          /Custom Title/
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
        expect(builder(company).tab(:name, :active => true) { "some content" }).to match(
          /class=\"tab-pane active\"/
        )
      end
    end

    describe "options[:id]" do
      it "fails" do
        expect(builder(company).tab(:name, :id => "people") { "some content"}).to match(
          /id=\"people\"/
        )
      end
    end
  end

  def store_translations(locale, translations)
    I18n.backend.store_translations locale, translations
  end

end
