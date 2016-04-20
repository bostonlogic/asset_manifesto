module AssetManifesto
  class Stylesheet < Base
    def self.create_manifests
      stylesheet_assets.each do |stylesheet_manifest|
        puts "creating stylesheet manifest files..."
        stylesheet_manifest.each do |manifest_filename, stylesheet_filenames|
          puts "  creating #{manifest_filename} manifest"
          File.open("#{Rails.root}/app/assets/stylesheets/#{manifest_filename}.css", "w") do |manifest_file|
            manifest_file.write "/* #{'#'*102}\n"
            manifest_file.write " * " + center_string("#{manifest_filename}.css") + "\n"
            manifest_file.write " * " + center_string("auto-generated from '#{manifest_filename}' in 'config/asset_packages.yml'") + "\n"
            manifest_file.write " * #{'#'*102}\n"
            manifest_file.write " *\n"
            stylesheet_filenames.each do |stylesheet_filename|
              manifest_file.write " *= require #{stylesheet_filename}\n"
            end
            manifest_file.write " */\n"
          end
        end
      end
      puts "done with stylesheet manifest files"
    end
  end
end
