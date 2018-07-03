require "test_helper"

class TabsFor::Rails::TabsForHelperTest < ActionView::TestCase

  def object
    @o ||= Struct.new(:name) do

      def self.human_attribute_name(attribute)
        I18n.t("activerecord.attributes.project.#{attribute}")
      end

    end.new("Project 1")
  end

  def with_concat_tabs_for(*args, &block)
    concat tabs_for(*args, &block)
  end

  def store_translations(locale, translations, &block)
    I18n.backend.store_translations locale, translations
    yield
  ensure
    I18n.reload!
    I18n.backend.send :init_translations
  end

  def assert_tab(name, content)
    assert_select "li[role=\"presentation\"]" do |element|
      assert_select(
        element,
        "a[aria-controls=\"#{name}\"][data-toggle=\"tab\"][role=\"tab\"][href=\"##{name}\"]",
        text: content
      )
    end
  end

  def assert_pane(id, text)
    assert_select "div[role=\"tabpanel\"][class=\"tab-pane\"][id=\"#{id}\"]", text: text
  end

  test "custom class for tabs" do
    tabs = tabs_for(object, class: 'tab-header') do |b|
      b.tab("Label") { "Content" }
    end

    concat tabs
    assert_select ".tab-header"
  end

  test "#tab renders tab with translated header with a corresponding pane" do
    store_translations(:en, activerecord: {attributes: {project: {name: "Nome"}}}) do
      with_concat_tabs_for(object) { |b| b.tab(:name, size: 1) { "Content" } }
    end

    assert_tab :name, "Nome 1"
    assert_pane :name, "Content"
  end

  test "#tab given a string it renders the tab with that string" do
    with_concat_tabs_for(object) { |b| b.tab("Statistics") { "Content" } }
    assert_select "a[aria-controls=\"statistics\"][data-toggle=\"tab\"][role=\"tab\"][href=\"#statistics\"]", text: "Statistics"
    assert_pane :statistics, "Content"
  end

  test "#tab given options[:active] sets the tab to active" do
    with_concat_tabs_for(object) { |b| b.tab(:name, active: true) {} }
    assert_select "li[role=\"presentation\"][class=\"active\"]"
  end

  test "#tab given options[:icon] renders the given icon" do
    with_concat_tabs_for(object) { |b| b.tab(:name, icon: "building") {} }
    assert_select "i[class=\"fa fa-building\"]"
  end

  test "#tab given options[:label] renders with the given label" do
    with_concat_tabs_for(object) { |b| b.tab(:name, label: "Custom Label") {} }
    assert_select "a", text: "Custom Label"
  end

  test "#tab given options[:help] renders a help text under the tab" do
    with_concat_tabs_for(object) { |b| b.tab(:name, help: "Only active projects") {} }
    assert_select "p" do |element|
      assert_select element, "i.fa-info-circle", text: "Only active projects"
    end
  end

  test "#tab given options[:id] renders the tab and pane with given id" do
    with_concat_tabs_for(object) { |b| b.tab(:name, id: :another_name) {} }
    assert_select "a[aria-controls=\"another_name\"][href=\"#another_name\"]"
    assert_select "div[id=\"another_name\"]"
  end
end
