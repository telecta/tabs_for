$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tabs_for'

Company = Struct.new(:name, :people) do

  def self.human_attribute_name(attribute_name)
    I18n.t("activerecord.attributes.company.#{attribute_name}")
  end

end

Person = Struct.new(:first_name, :last_name)
