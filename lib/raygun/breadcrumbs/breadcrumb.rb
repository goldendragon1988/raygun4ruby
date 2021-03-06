module Raygun
  module Breadcrumbs
    class Breadcrumb
      ATTRIBUTES = [
        :message, :category, :metadata, :class_name,
        :method_name, :line_number, :timestamp, :level,
        :type
      ]
      attr_accessor(*ATTRIBUTES)

      def build_payload
        payload = {
          message: message,
          category: category,
          level: Breadcrumbs::BREADCRUMB_LEVELS.index(level),
          CustomData: metadata,
          timestamp: timestamp,
          type: type
        }

        payload[:location] = "#{class_name}:#{method_name}" unless class_name == nil
        payload[:location] += ":#{line_number}" if payload.has_key?(:location) && line_number != nil

        Hash[payload.select do |k, v|
          v != nil
        end]
      end
    end
  end
end
