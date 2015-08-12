module TabsFor
  module TabsForHelper

    def tabs_for(object, &block)
      content_tag(:ul, :class => "nav nav-tabs", :role => "tablist") do
        capture TabBuilder.new(object, self), &block
      end + content_tag(:div, :class => "tab-content") do
        capture PaneBuilder.new(object, self), &block
      end
    end

    class TabBuilder
      include ActionView::Helpers

      attr_accessor :object, :template, :output_buffer

      def initialize(object, template)
        @object, @template = object, template
      end

      def tab(attribute, options = {})
        content = if object.respond_to? attribute
          human_name attribute
        else
          attribute.to_s.capitalize
        end

        options[:id] ||= attribute.to_s.downcase

        if options[:size]
          content += " " + content_tag(:span, options[:size], :class => "badge")
        end

        content_tag(:li, role: "presentation", class: options[:active] ? "active" : nil) do
          link_to "#" + attribute.to_s.downcase, "aria-controls" => attribute.to_s.downcase, "data-toggle" => "tab", :role => "tab" do
            options[:icon] ? wrap_with_icon(content.html_safe, options) : content.html_safe
          end
        end
      end

      private

      def wrap_with_icon(content, options = {})
        content_tag(:i, " " + content, class: options[:icon])
      end

      def human_name(attribute_name)
        object.class.human_attribute_name attribute_name
      end

    end

    class PaneBuilder
      include ActionView::Helpers

      attr_accessor :object, :template

      def initialize(object, template)
        @object, @template = object, template
      end

      def tab(attribute, options = {}, &block)
        content_tag(:div, template.capture(&block), :role => "tabpanel",
                    :class => "tab-pane" + (options[:active] ? " active" : ""), :id => attribute.to_s)
      end

    end

  end
end
