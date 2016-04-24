module AssetManifesto
  class AssetPathInjector < Base

    def process input_string
      asset_path_string = add_asset_path input_string
      asset_path_string = remove_image asset_path_string
      asset_path_string = remove_leading_slash asset_path_string
      add_quotes asset_path_string
    end

    def add_asset_path input_string
      input_string.gsub(/url\((.*?)\)/){"url(<%= asset_path #{$1} %>)"}
    end

    def remove_image input_string
       input_string.gsub(/\/images\//, '')
    end

    def remove_leading_slash input_string
      input_string.gsub(/asset_path ([\'|\"]?)\//){"asset_path #{$1}"}
    end

    def add_quotes input_string
      input_string.gsub(/asset_path (\w\S*) %>/){"asset_path '#{$1}' %>"}
    end

    class << self
      def to_asset_pipeline input_string
        @asset_path_injector ||= AssetPathInjector.new
        @asset_path_injector.process input_string
      end
    end
  end
end
