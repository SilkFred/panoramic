module Panoramic
  module Orm
    module Mongoid
      def store_templates
        class_eval do
          include ::Mongoid::Timestamps

          field :body
          field :path
          field :format
          field :locale
          field :handler
          field :partial, :type => Boolean, :default => false

          validates :body,    :presence => true
          validates :path,    :presence => true
          validates :format,  :inclusion => Mime::SET.symbols.map(&:to_s)
          validates :locale,  :inclusion => I18n.available_locales.map(&:to_s)
          validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)

          after_save { Panoramic::Resolver.instance.clear_cache }

          extend ClassMethods
        end
      end

      module ClassMethods
        def find_model_templates(conditions = {})
          self.where(conditions)
        end

        def resolver(options={})
          Panoramic::Resolver.using self, options
        end
      end
    end
  end
end

Mongoid::Document::ClassMethods.send :include, Panoramic::Orm::Mongoid
