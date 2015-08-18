module TabsFor
  module TabsForHelper

    def tabs_for(object, &block)
      content_tag(:ul, :class => "nav nav-tabs", :role => "tablist") do
        capture TabBuilder.new(object, self), &block
      end + content_tag(:div, :class => "tab-content") do
        capture PaneBuilder.new(object, self), &block
      end
    end

    class ViewBuilder
      include ActionView::Helpers

      attr_accessor :object, :template, :output_buffer

      def initialize(object, template)
        @object, @template = object, template
      end

      private

      def identifier(attribute)
        attribute.to_s.downcase
      end

    end

    class TabBuilder < ViewBuilder

      def tab(attribute, options = {})
        content = if options[:title]
          options.delete(:title)
        elsif object.respond_to? attribute
          human_name attribute
        else
          attribute.to_s.titleize
        end

        options[:id] ||= identifier(attribute)

        if options[:size]
          content += " " + content_tag(:span, options[:size], :class => "badge")
        end

        content_tag(:li, apply_options(attribute, options)) do
          link_to "#" + identifier(attribute), apply_link_options(attribute, options) do
            options[:icon] ? wrap_with_icon(content.html_safe, options) : content.html_safe
          end
        end
      end

      private

      def apply_link_options(attribute, options)
        {
          "aria-controls" => identifier(attribute),
          "data-toggle" => "tab",
          :role => "tab",
        }
      end

      def apply_options(attribute, options)
        {
          :role => "presentation",
          :class => options[:active] ? "active" : nil,
        }
      end

      def human_name(attribute_name)
        object.class.human_attribute_name attribute_name
      end

      def wrap_with_icon(content, options = {})
        content_tag(:i, " ".html_safe + content, :class => options[:icon])
      end

    end

    class PaneBuilder < ViewBuilder

      def tab(attribute, options = {}, &block)
        content = "".html_safe

        if options[:help]
          content += content_tag(:p) do
            content_tag(:i, " #{options[:help]}".html_safe, class: "fa fa-info-circle")
          end
        end

        content += template.capture(&block)

        content_tag(:div, content, apply_options(attribute, options))
      end

      private

      def apply_options(attribute, options)
        {
          :role => "tabpanel",
          :class => "tab-pane" + (options[:active] ? " active" : ""),
          :id => options[:id] ? options[:id] : identifier(attribute),
        }
      end

    end

  end
end
