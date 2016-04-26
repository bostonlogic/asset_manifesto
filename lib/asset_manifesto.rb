require "asset_manifesto/version"
require "asset_manifesto/base"
require "asset_manifesto/javascript"
require "asset_manifesto/stylesheet"
require "asset_manifesto/assets_initializer"
require "asset_manifesto/asset_path_injector"

module AssetManifesto
  class << self

    def generate_all_manifests
      AssetManifesto::Javascript.create_manifests
      AssetManifesto::Stylesheet.create_manifests
    end

    def asset_pipeline_setup
      AssetManifesto::AssetsInitializer.create_asset_initializer
      AssetManifesto::Javascript.create_manifests
      AssetManifesto::Stylesheet.create_manifests
    end

  end
end
