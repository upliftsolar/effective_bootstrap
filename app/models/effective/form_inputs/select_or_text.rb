module Effective
  module FormInputs
    class SelectOrText < Effective::FormInput
      attr_accessor :name_text
      attr_accessor :select_collection
      attr_accessor :select_options
      attr_accessor :text_options

      VISIBLE = {}
      HIDDEN = { wrapper: { style: 'display: none;' } }

      def initialize(name, options, builder:)
        @name_text = options.delete(:name_text) || raise('Please include a text method name')
        @select_collection = options.delete(:collection) || raise('Please include a collection')

        @select_options = { placeholder: 'Please choose, or...', required: false }
          .merge(options[:select] || options.presence || {})

        @text_options = { placeholder: 'Enter freeform', required: false }
          .merge(options[:text] || options[:text_field] || options.presence || {})

        super
      end

      def to_html(&block)
        content_tag(:div, class: 'effective-select-or-text') do
          @builder.select(name, select_collection, select_options) +
          @builder.text_field(name_text, text_options) +
          link_to(icon('rotate-ccw'), '#', class: 'effective-select-or-text-switch', title: 'Switch between choice and freeform', 'data-effective-select-or-text': true)
        end
      end

      def select?
        return true if object.errors[name].present?
        return false if object.errors[name_text].present?

        object.send(name).present? || (object.send(name).blank? && object.send(name_text).blank?)
      end

      def text?
        return false if object.errors[name].present?

        object.send(name_text).present? || object.errors[name_text].present?
      end

      def select_options
        @select_options.merge(select? ? VISIBLE : HIDDEN)
      end

      def text_options
        @text_options.merge(text? ? VISIBLE : HIDDEN)
      end

    end
  end
end