module Effective
  module FormLogics
    class HideIf < Effective::FormLogic

      def to_html(&block)
        disabled_was = @builder.disabled

        @builder.disabled = true if hide?

        content = content_tag(:div, options.merge(input_js_options), &block)

        @builder.disabled = disabled_was

        content
      end

      def options
        { style: ('display: none;' if hide?) }
      end

      def logic_options
        { name: tag_name(args.first), value: args.second.to_s }.merge(input_logic_options)
      end

      def input_logic_options
        args.third.kind_of?(Hash) ? args.third : {}
      end

      def validate!(args)
        raise "expected object to respond to #{args.first}" unless object.respond_to?(args.first)
      end

      def hide?
        (object.send(args.first) == args.second) || (object.send(args.first).to_s == args.second.to_s)
      end

    end
  end
end
