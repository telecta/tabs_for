module TabsFor
  module Rails
    module TabsForHelper

      def tabs_for(object, options={}, &block)
        classes = 'nav nav-tabs'
        classes = options.delete(:class) if options[:class]

        content_tag(:ul, class: classes, role: 'tablist') do
          capture TabBuilder.new(object, self), &block
        end + content_tag(:div, class: 'tab-content') do
          capture PaneBuilder.new(object, self), &block
        end
      end

      class ViewBuilder
        include ActionView::Helpers

        attr_accessor :object, :template, :output_buffer

        def initialize(object, template)
          @object = object
          @template = template
        end

        private

        def identifier(attribute)
          attribute.to_s.downcase
        end
      end

      class TabBuilder < ViewBuilder
        include FontAwesome::Rails::IconHelper

        def tab(attribute, options = {})
          content = if options[:label]
                      options.delete(:label)
                    elsif object.respond_to? attribute
                      human_name attribute
                    else
                      attribute.to_s.titleize
                    end

          id = options[:id] ? options[:id].to_s : identifier(attribute)

          if options[:size]
            content += ' ' + content_tag(:span, options[:size], class: 'badge')
          end

          content_tag(:li, apply_options(attribute, options)) do
            link_to '#' + id, apply_link_options(id) do
              if options[:icon]
                wrap_with_icon(content.html_safe, options)
              else
                content.html_safe
              end
            end
          end
        end

        private

        def apply_link_options(id)
          {
            'aria-controls' => id,
            'data-toggle' => 'tab',
            role: 'tab'
          }
        end

        def apply_options(attribute, options)
          {
            role: 'presentation',
            class: options[:active] ? 'active' : nil
          }
        end

        def human_name(attribute_name)
          object.class.human_attribute_name attribute_name
        end

        def wrap_with_icon(content, options = {})
          fa_icon(options[:icon], text: content)
        end
      end

      class PaneBuilder < ViewBuilder

        def tab(attribute, options = {}, &block)
          content = ''.html_safe

          if options[:help]
            content += tag(:br)
            content += content_tag(:p) do
              content_tag(:i, " #{options[:help]}".html_safe, class: 'fa fa-info-circle')
            end
          end

          content += template.capture(&block)

          content_tag(:div, content, apply_options(attribute, options))
        end

        private

        def apply_options(attribute, options)
          {
            role: 'tabpanel',
            class: 'tab-pane' + (options[:active] ? ' active' : ''),
            id: options[:id] ? options[:id] : identifier(attribute)
          }
        end
      end
    end
  end
end
