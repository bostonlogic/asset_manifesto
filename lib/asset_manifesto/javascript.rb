module AssetManifesto
  class Javascript < Base
    def self.create_manifests
      javascript_assets.each do |javascript_manifest|
        puts "creating javascript manifest files..."
        javascript_manifest.each do |manifest_filename, javascript_filenames|
          puts "  Creating #{manifest_filename} manifest"
          File.open("#{Rails.root}/app/assets/javascripts/#{manifest_filename}.js", "w") do |manifest_file|
            manifest_file.write "//\n"
            manifest_file.write "// #{manifest_filename}.js\n"
            manifest_file.write "// auto-generated from '#{manifest_filename}' in 'config/asset_packages.yml'\n"
            manifest_file.write "//\n"
            javascript_filenames.each do |javascript_filename|
              manifest_file.write "//= require #{javascript_filename}\n"
            end
          end
        end
      end
      puts "done with javascript manifest files"
    end
  end
end
