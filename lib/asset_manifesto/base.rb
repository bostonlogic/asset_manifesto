module AssetManifesto
  class Base
    class << self

      def load_yaml
        YAML.load_file "#{Rails.root}/config/asset_packages.yml"
      end

      def center_string(content, length = 102, padding = "#")
        " #{content} ".center(length, padding)
      end

      def javascript_assets
        load_yaml["javascripts"]
      end

      def stylesheet_assets
        load_yaml["stylesheets"]
      end

    end
  end
end
