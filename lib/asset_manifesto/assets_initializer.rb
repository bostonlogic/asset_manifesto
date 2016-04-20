module AssetManifesto
  class AssetsInitializer < Base
    def self.create_asset_initializer
      File.open("#{Rails.root}/config/initializers/assets.rb", "w") do |asset_initializer|
        asset_initializer.write 'assets = YAML.load_file "#{Rails.root}/config/asset_packages.yml"'
        asset_initializer.write "\n\n"
        asset_initializer.write 'stylesheet_manifests = assets["stylesheets"].map{ |stylesheet_manifest| "#{stylesheet_manifest.keys.first}.css" }'
        asset_initializer.write "\n"
        asset_initializer.write 'javascript_manifests = assets["javascripts"].map{ |javascript_manifest| "#{javascript_manifest.keys.first}.js" }'
        asset_initializer.write "\n\n"
        asset_initializer.write "assets_maninfests = javascript_manifests + stylesheet_manifests\n\n"
        asset_initializer.write "Rails.application.config.assets.precompile = assets_maninfests\n"
      end
    end
  end
end
