require 'fileutils'
require 'tempfile'

module AssetManifesto
  class Stylesheet < Base

    class << self
      def process_stylesheets
        Dir.glob("#{Rails.root}/public/stylesheets/**/*").each do |stylesheet|
          puts "Processing #{stylesheet}..."
          relative_path = stylesheet.split('/public/').last
          temp_stylesheet = Tempfile.new('temp_stylesheet.css')
          File.open(stylesheet, 'r') do |file|
            file.lines{|line| temp_stylesheet.puts AssetPathInjector.to_asset_pipeline line }
          end
          temp_stylesheet.close
          FileUtils.mv(temp_stylesheet.path, "#{Rails.root}/app/assets/#{relative_path}.erb")
          puts " - #{stylesheet} processed, it is now #{Rails.root}/app/assets/#{relative_path}.erb"
          puts " - You should verify the processed file, and then delete the source file"
        end
      end

      def create_manifests
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
end
